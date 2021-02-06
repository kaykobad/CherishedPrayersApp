import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

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

  Future<Either<ErrorModel, DetailOnlyResponse>> resetPassword(ResetPasswordRequest data) async {
    try {
      var response = await _dio.post(ApiEndpoints.RESET_PASSWORD, data: data);
      if (response['error'] != null) {
        return Left(ErrorModel.fromJson(response));
      }
      return Right(DetailOnlyResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel(error, [stacktrace.toString()]));
    }
  }

  Future<Either<ErrorModel, DetailOnlyResponse>> confirmPasswordReset(ConfirmPasswordResetRequest data) async {
    try {
      var response = await _dio.post(ApiEndpoints.RESET_PASSWORD_CONFIRMATION, data: data);
      if (response['error'] != null) {
        return Left(ErrorModel.fromJson(response));
      }
      return Right(DetailOnlyResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel(error, [stacktrace.toString()]));
    }
  }

  Future<DetailOnlyResponse> sendFeedback(FeedbackRequest data, String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.POST_FEEDBACK, data: data, options: Options (
        headers: {
          "Authorization" : "Token $authToken",
        }
      ));
      return DetailOnlyResponse.fromJson(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return DetailOnlyResponse("Error! Something went wrong. please try again later.");
    }
  }
}