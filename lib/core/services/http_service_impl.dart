import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../error/exception_model.dart';
import '../error/http_exception.dart';
import '../error/http_failure.dart';
import 'http_service.dart';

class HttpServiceImpl implements HttpService {
  @override
  Future<Either<HttpFailure, T?>> get<T>({
    required String url,
    String? query,
    required T? Function(dynamic p1) fromJson,
    Map<String, dynamic> headers = const {},
    bool requireToken = true,
  }) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');
      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .get(
        urlParsed,
        headers: requestHeaders,
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
  Future<Either<HttpFailure, T?>> post<T>(
      {required String url,
      String? query,
      required T? Function(dynamic p1) fromJson,
      Map<String, dynamic>? body,
      Map<String, dynamic> headers = const {},
      bool requireToken = true}) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');

      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .post(
        body: body,
        urlParsed,
        headers: requestHeaders,
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
  Future<Either<HttpFailure, T?>> put<T>(
      {required String url,
      String? query,
      required T? Function(dynamic p1) fromJson,
      Map<String, dynamic>? body,
      Map<String, dynamic> headers = const {},
      bool requireToken = true}) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');

      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .put(
        body: body,
        urlParsed,
        headers: requestHeaders,
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
  Future<Either<HttpFailure, T?>> patch<T>(
      {required String url,
      String? query,
      required T? Function(dynamic p1) fromJson,
      Map<String, dynamic>? body,
      Map<String, dynamic> headers = const {},
      bool requireToken = true}) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');

      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .patch(
        body: body,
        urlParsed,
        headers: requestHeaders,
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
  Future<Either<HttpFailure, T?>> delete<T>(
      {required String url,
      String? query,
      required T? Function(dynamic p1) fromJson,
      Map<String, dynamic>? body,
      Map<String, dynamic> headers = const {},
      bool requireToken = true}) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');

      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .delete(
        body: body,
        urlParsed,
        headers: requestHeaders,
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
  Future<Either<HttpFailure, T?>> request<T>({
    required String url,
    required String method,
    required T? Function(dynamic p1) fromJson,
    required Map<String, dynamic> fields,
  }) async {
    try {
      final parsedUrl = Uri.parse(url);
      final request = http.MultipartRequest(method, parsedUrl);

      var headers = await _buildRequestHeader({}, true);

      for (var header in headers.entries) {
        request.headers[header.key] = header.value;
      }

      // Add form fields
      for (var field in fields.entries) {
        //  if the field is file
        if (field.value is File) {
          request.files.add(await http.MultipartFile.fromPath(
            field.key, // Field name for the file
            (field.value as File).path, // Path to the file on the device
          ));
          // is it is list of files
        } else if (field.value is List<File>) {
          for (var fileSpecific in field.value as List<File>) {
            request.files.add(await http.MultipartFile.fromPath(
              field.key, // Field name for the file
              fileSpecific.path, // Path to the file on the device
            ));
          }
          // if it is normal field
        } else {
          request.fields[field.key] = field.value;
        }
      }

      // Send the request
      final response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException(
              'Sorry, the operation took too long to complete. Please try again!');
        },
      );

      var bytesToString = await response.stream.bytesToString();

      return _handleResponse(
          response.statusCode, bytesToString, fromJson, parsedUrl);
    } catch (error) {
      return handleException(error);
    }
  }

  Future<Map<String, String>> _buildRequestHeader(
      Map<String, dynamic> headers, bool requireToken) async {
    Map<String, String> requestHeaders = {
      'Accept': "application/json",
      ...headers,
    };

    return requestHeaders;
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

  @override
  Future<Either<HttpFailure, T?>> loadJson<T>({
    required String path,
    required T? Function(dynamic p1) fromJson,
  }) async {
    try {
      final String response = await rootBundle.loadString(path);
      final data = await json.decode(response);
      final parsedModel = fromJson(data);

      return right(parsedModel);
    } catch (error) {
      return handleException(error);
    }
  }
}
