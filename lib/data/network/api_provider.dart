import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'dio_provider.dart';

class ApiProvider {
  final _dio = DioProvider();

  // Authentication
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

  // Feedback
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

  // Profile
  Future<UpdateProfilePictureResponse> updateProfilePicture(UpdateProfilePictureRequest data, String authToken) async {
    try {
      FormData formData = FormData.fromMap({
        "avatar": await MultipartFile.fromFile(data.avatar),
      });
      var response = await _dio.post(ApiEndpoints.UPDATE_PROFILE_PICTURE, data: formData, options: Options (
        headers: {
          "Authorization" : "Token $authToken",
        }
      ));
      return UpdateProfilePictureResponse.fromJson(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return UpdateProfilePictureResponse("Error! Something went wrong. Please try again later.", "");
    }
  }

  // Configurations
  Future<Either<ErrorModel, AllCountriesResponse>> getAllCountries() async {
    try {
      var response = await _dio.get(ApiEndpoints.GET_ALL_COUNTRIES);
      return Right(AllCountriesResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel("Error! Something went wrong. Please try again later.", [""]));
    }
  }

  Future<Either<ErrorModel, AllLanguagesResponse>> getAllLanguages() async {
    try {
      var response = await _dio.get(ApiEndpoints.GET_ALL_LANGUAGES);
      return Right(AllLanguagesResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel("Error! Something went wrong. Please try again later.", [""]));
    }
  }

  Future<Either<ErrorModel, AllReligionsResponse>> getAllReligions() async {
    try {
      var response = await _dio.get(ApiEndpoints.GET_ALL_RELIGIONS);
      return Right(AllReligionsResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel("Error! Something went wrong. Please try again later.", [""]));
    }
  }

  // 1: Country, 2: Language, 3: Religion
  Future<Either<ErrorModel, DetailOnlyResponse>> updateCLR(UpdateValueRequest data, String authToken, int selector) async {
    try {
      List<String> _urls = [ApiEndpoints.UPDATE_COUNTRY, ApiEndpoints.UPDATE_LANGUAGE, ApiEndpoints.UPDATE_RELIGION];
      var response = await _dio.post(_urls[selector-1], data: data, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));

      if (response['detail'].contains("Success")) {
        return Right(DetailOnlyResponse.fromJson(response));
      } else {
        return Left(ErrorModel(response["detail"], [""]));
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(ErrorModel("Error! Something went wrong. Please try again later.", [""]));
    }
  }
}