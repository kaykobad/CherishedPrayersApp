import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:dartz/dartz.dart';

import 'dio_provider.dart';

class ApiProvider {
  final _dio = DioProvider();

  Future<Either<ErrorModel, AuthUserResponse>> login(LoginRequest data) async {
    try {
      var response = await _dio.post(ApiEndpoints.LOGIN, data: data);
      if (response['error'] != null) {
        return Left(ErrorModel.fromJson(response));
      }
      return Right(AuthUserResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel(error, [stacktrace.toString()]));
    }
  }

  Future<Either<ErrorModel, AuthUserResponse>> register(RegisterRequest data) async {
    try {
      var response = await _dio.post(ApiEndpoints.REGISTER, data: data);
      if (response['error'] != null) {
        return Left(ErrorModel.fromJson(response));
      }
      return Right(AuthUserResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel(error, [stacktrace.toString()]));
    }
  }

  Future<Either<ErrorModel, EmailVerificationResponse>> verifyEmail(VerifyEmailRequest data) async {
    try {
      var response = await _dio.post(ApiEndpoints.EMAIL_VERIFY, data: data);
      if (response['error'] != null) {
        return Left(ErrorModel.fromJson(response));
      }
      return Right(EmailVerificationResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel(error, [stacktrace.toString()]));
    }
  }

  Future<Either<ErrorModel, DetailOnlyResponse>> confirmEmailVerification(ConfirmVerifyEmailRequest data) async {
    try {
      var response = await _dio.post(ApiEndpoints.EMAIL_VERIFY_CONFIRMATION, data: data);
      if (response['error'] != null) {
        return Left(ErrorModel.fromJson(response));
      }
      return Right(DetailOnlyResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel(error, [stacktrace.toString()]));
    }
  }
}