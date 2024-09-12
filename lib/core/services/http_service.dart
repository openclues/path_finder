import 'package:dartz/dartz.dart';
import '../error/http_failure.dart';

abstract class HttpService {
  Future<Either<HttpFailure, T?>> get<T>({
    required String url,
    required T? Function(dynamic) fromJson,
  });

  Future<Either<HttpFailure, T?>> post<T>({
    required String url,
    required T? Function(dynamic) fromJson,
    Map<String, dynamic>? body,
  });
}
