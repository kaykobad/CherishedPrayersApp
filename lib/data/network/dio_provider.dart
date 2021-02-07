import 'dart:io';

import 'package:cherished_prayers/data/models/models.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_endpoints.dart';

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
      return ErrorModel("No Internet!", ["Please check internet connection and try again."]).toJson();
    } on Exception catch (e) {
      return ErrorModel("Error!", [e.toString()]).toJson();
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
      return ErrorModel("No Internet!", ["Please check internet connection and try again."]).toJson();
    } on Exception catch (e) {
      return ErrorModel("Error!", ["Please check internet connection or try again later."]);
    }
  }
}