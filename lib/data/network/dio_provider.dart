import 'dart:io';

import 'package:cherished_prayers/data/models/models.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_endpoints.dart';

final genericError = {
  "error": "Something went wrong!",
  "details": ["Please check internet connection or try again later."]
};

class DioProvider {
  final String _baseUrl = ApiEndpoints.BASE_URL;
  Dio _dio;

  DioProvider() {
    _init();
  }

  _init() {
    if (_dio == null) {
      _dio = Dio();
      _dio..options.baseUrl = _baseUrl;
      _dio..options.connectTimeout = 10000;
      _dio..options.receiveTimeout = 10000;
      _dio..options.sendTimeout = 10000;
      _dio.interceptors.add(PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          maxWidth: 90,
          compact: true
      ));

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        };
    }
  }

  Future<dynamic> get(
      String uri, {
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onReceiveProgress,
      }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException {
      return genericError;
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        return e.response.data;
      } else {
        return genericError;
      }
    } on Exception catch (e) {
      return genericError;
    }
  }

  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic> queryParameters,
        Options options,
        CancelToken cancelToken,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
      }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException {
      return genericError;
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        return e.response.data;
      } else {
        return genericError;
      }
    } on Exception catch (e) {
      return genericError;
    }
  }
}