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

  Future<DetailOnlyResponse> reportBug(ReportBugRequest data, String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.REPORT_BUG, data: data, options: Options (
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

  // Friends
  Future<DetailOnlyResponse> sendFriendRequest(String authToken, int userId) async {
    try {
      var response = await _dio.post(ApiEndpoints.SEND_FRIEND_REQUEST.replaceAll("uid", userId.toString()), options: Options (
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

  Future<Either<DetailOnlyResponse, GetAllFriendsResponse>> getAllFriends(String authToken) async {
    try {
      var response = await _dio.get(ApiEndpoints.GET_ALL_FRIENDS, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GetAllFriendsResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, GetAllSentFriendRequestResponse>> getAllSentFriendRequests(String authToken) async {
    try {
      var response = await _dio.get(ApiEndpoints.GET_ALL_SENT_REQUEST, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GetAllSentFriendRequestResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, GetAllReceivedFriendRequestResponse>> getAllReceivedFriendRequests(String authToken) async {
    try {
      var response = await _dio.get(ApiEndpoints.GET_ALL_RECEIVED_REQUEST, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GetAllReceivedFriendRequestResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<DetailOnlyResponse> unFriend(String authToken, int userId) async {
    try {
      var response = await _dio.post(ApiEndpoints.UN_FRIEND.replaceAll("uid", userId.toString()), options: Options (
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

  Future<DetailOnlyResponse> acceptFriendRequest(String authToken, int reqId) async {
    try {
      var response = await _dio.post(ApiEndpoints.ACCEPT_FRIEND_REQUEST.replaceAll("rid", reqId.toString()), options: Options (
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

  Future<DetailOnlyResponse> rejectFriendRequest(String authToken, int reqId) async {
    try {
      var response = await _dio.post(ApiEndpoints.REJECT_FRIEND_REQUEST.replaceAll("rid", reqId.toString()), options: Options (
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

  Future<DetailOnlyResponse> cancelFriendRequest(String authToken, int reqId) async {
    try {
      var response = await _dio.post(ApiEndpoints.CANCEL_FRIEND_REQUEST.replaceAll("rid", reqId.toString()), options: Options (
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

  Future<Either<DetailOnlyResponse, GetFriendSuggestionsResponse>> getFriendSuggestions(String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.FRIEND_SUGGESTIONS, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GetFriendSuggestionsResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, SearchPeopleResponse>> searchPeople(SearchPeopleRequest data, String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.SEARCH_PEOPLE, data: data, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(SearchPeopleResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<DetailOnlyResponse> blockUser(String authToken, int userId) async {
    try {
      var response = await _dio.post(ApiEndpoints.BLOCK_USER.replaceAll("uid", userId.toString()), options: Options (
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

  Future<DetailOnlyResponse> unBlockUser(String authToken, int userId) async {
    try {
      var response = await _dio.post(ApiEndpoints.UN_BLOCK_USER.replaceAll("uid", userId.toString()), options: Options (
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

  Future<Either<DetailOnlyResponse, GetAllBlockedUsersResponse>> getBlockedUsers(String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.GET_BLOCKED_USERS, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GetAllBlockedUsersResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  // Feed
  Future<Either<DetailOnlyResponse, PostResponse>> createPost(PostRequest data, String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.CREATE_POST, data: data, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(PostResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, GenericPostResponse>> updatePost(PostRequest data, String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.UPDATE_POST, data: data, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GenericPostResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, AllPostsResponse>> getAllMyPosts(String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.UPDATE_POST, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(AllPostsResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<DetailOnlyResponse> deletePost(String authToken, int postId) async {
    try {
      var response = await _dio.post(ApiEndpoints.DELETE_POST.replaceAll("pid", postId.toString()), options: Options (
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

  Future<Either<DetailOnlyResponse, GenericPostResponse>> getPostDetails(String authToken, int postId) async {
    try {
      var response = await _dio.post(ApiEndpoints.POST_DETAILS.replaceAll("pid", postId.toString()), options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GenericPostResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<DetailOnlyResponse> likePost(String authToken, int postId) async {
    try {
      var response = await _dio.post(ApiEndpoints.LIKE_POST.replaceAll("pid", postId.toString()), options: Options (
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

  Future<Either<DetailOnlyResponse, AllPostsResponse>> getMyFeed(String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.MY_FEED, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(AllPostsResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, GenericPostResponse>> addComment(AddCommentRequest data, String authToken) async {
    try {
      var response = await _dio.post(ApiEndpoints.ADD_COMMENT, data: data, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GenericPostResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, GenericPostResponse>> updateComment(UpdateCommentRequest data, String authToken, int commentId) async {
    try {
      var response = await _dio.post(ApiEndpoints.UPDATE_COMMENT.replaceAll("cid", commentId.toString()), data: data, options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GenericPostResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<Either<DetailOnlyResponse, GenericPostResponse>> deleteComment(String authToken, int commentId) async {
    try {
      var response = await _dio.post(ApiEndpoints.UPDATE_COMMENT.replaceAll("cid", commentId.toString()), options: Options (
          headers: {
            "Authorization" : "Token $authToken",
          }
      ));
      if (response['detail'] != null) {
        return Left(DetailOnlyResponse.fromJson(response));
      }
      return Right(GenericPostResponse.fromJson(response));
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return Left(DetailOnlyResponse("Error! Something went wrong. please try again later."));
    }
  }

  Future<DetailOnlyResponse> likeComment(String authToken, int commentId) async {
    try {
      var response = await _dio.post(ApiEndpoints.LIKE_COMMENT.replaceAll("cid", commentId.toString()), options: Options (
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