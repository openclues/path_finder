import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../error/exception_model.dart';
import '../error/http_exception.dart';
import '../error/http_failure.dart';
import 'http_service.dart';

class HttpServiceImpl implements HttpService {
  @override
  Future<Either<HttpFailure, T?>> get<T>({
    required String url,
    required T? Function(dynamic p1) fromJson,
  }) async {
    try {
      final urlParsed = Uri.parse(url);

      final response = await http
          .get(
        urlParsed,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'Sorry, the operation took too long to complete. Please try again!');
      });
      return _handleResponse(
          response.statusCode, response.body, fromJson, urlParsed);
    } catch (error) {
      return handleException(error);
    }
  }

  @override
  Future<Either<HttpFailure, T?>> post<T>({
    required String url,
    required T? Function(dynamic p1) fromJson,
    Map<String, dynamic>? body,
  }) async {
    try {
      final urlParsed = Uri.parse(url);

      final response = await http
          .post(
        body: body,
        urlParsed,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'Sorry, the operation took too long to complete. Please try again!');
      });
      return _handleResponse(
          response.statusCode, response.body, fromJson, urlParsed);
    } catch (error) {
      return handleException(error);
    }
  }

  Either<HttpFailure, T?> _handleResponse<T>(
    int statusCode,
    String body,
    T? Function(dynamic) fromJson,
    Uri parsedPath,
  ) {
    bool isEmptyBody = body.isEmpty;
    if (statusCode == HttpStatus.noContent) {
      return right(null);
    }

    // Handling the unauthorized case
    if (statusCode == HttpStatus.unauthorized) {
      throw NotAuthenticatedHttpException(
          _getErrorMessageString(HttpStatus.unauthorized));
    }

    // Handling the execption part
    if (statusCode > 299) {
      if (isEmptyBody) {
        throw HttpException(_getErrorMessageString(statusCode),
            statusCode: statusCode);
      } else {
        // first check if the response.body is not equals to null
        final error = ExceptionModel.fromJson(jsonDecode(body));
        throw HttpException(error.message,
            statusCode: statusCode, code: error.code);
      }
    }

    final parsedModel = fromJson(jsonDecode(body));
    return right(parsedModel);
  }

  String _getErrorMessageString(int statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return 'Bad Request: The server could not understand the request.';
      case HttpStatus.unauthorized:
        return 'Unauthorized: The request requires user authentication.';
      case HttpStatus.forbidden:
        return 'Forbidden: The server understood the request, but refuses to authorize it.';
      case HttpStatus.notFound:
        return 'Not Found: The requested resource could not be found.';
      case HttpStatus.internalServerError:
        return 'Internal Server Error: The server encountered an unexpected condition.';
      case HttpStatus.serviceUnavailable:
        return 'Service Unavailable: The server is currently unavailable.';
      default:
        return 'HTTP Error: Received status code $statusCode.';
    }
  }
}
