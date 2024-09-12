import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path_finder/core/error/http_failure.dart';
import 'package:path_finder/core/services/http_service.dart';

class DioServiceImpl implements HttpService {
  final Dio _dio;

  DioServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<HttpFailure, T?>> get<T>({
    required String url,
    required T? Function(dynamic p1) fromJson,
    void Function(int received, int total)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(fromJson(response.data));
    } catch (error) {
      return Left(errorFromDioError(error));
    }
  }

  @override
  Future<Either<HttpFailure, T?>> post<T>({
    required String url,
    required T? Function(dynamic p1) fromJson,
    Map<String, dynamic>? body,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        onSendProgress: onSendProgress,
        options: Options(responseType: ResponseType.plain),
      );
      return Right(fromJson(response.data));
    } catch (error) {
      return Left(errorFromDioError(error));
    }
  }
}

HttpFailure errorFromDioError(dynamic error) {
  if (error is DioException) {
    if (error.response != null) {
      return ServerHttpFailure(error.response!.data['message'],
          code: error.response!.statusCode,
          statusCode: error.response!.statusCode);
    } else {
      return ServerHttpFailure(error.message ?? 'Something Went Wrong');
    }
  } else {
    return const InternalAppHttpFailure('Something Went Wrong');
  }
}
