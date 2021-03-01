// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) {
  return VerifyEmailRequest(
    json['email'] as String,
  );
}

Map<String, dynamic> _$VerifyEmailRequestToJson(VerifyEmailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

ConfirmVerifyEmailRequest _$ConfirmVerifyEmailRequestFromJson(
    Map<String, dynamic> json) {
  return ConfirmVerifyEmailRequest(
    json['email'] as String,
    json['verification_code'] as String,
  );
}

Map<String, dynamic> _$ConfirmVerifyEmailRequestToJson(
        ConfirmVerifyEmailRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verification_code': instance.verificationCode,
    };

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return RegisterRequest(
    json['email'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'password': instance.password,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return LoginRequest(
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

ChangePasswordRequest _$ChangePasswordRequestFromJson(
    Map<String, dynamic> json) {
  return ChangePasswordRequest(
    json['current_password'] as String,
    json['new_password'] as String,
    json['new_password_2'] as String,
  );
}

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'current_password': instance.currentPassword,
      'new_password': instance.newPassword,
      'new_password_2': instance.newPassword2,
    };

ResetPasswordRequest _$ResetPasswordRequestFromJson(Map<String, dynamic> json) {
  return ResetPasswordRequest(
    json['email'] as String,
  );
}

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

ConfirmPasswordResetRequest _$ConfirmPasswordResetRequestFromJson(
    Map<String, dynamic> json) {
  return ConfirmPasswordResetRequest(
    json['email'] as String,
    json['token'] as String,
    json['new_password'] as String,
    json['new_password_2'] as String,
  );
}

Map<String, dynamic> _$ConfirmPasswordResetRequestToJson(
        ConfirmPasswordResetRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
      'new_password': instance.newPassword,
      'new_password_2': instance.newPassword2,
    };

ConfirmVerifyEmailResponse _$ConfirmVerifyEmailResponseFromJson(
    Map<String, dynamic> json) {
  return ConfirmVerifyEmailResponse(
    json['detail'] as String,
  );
}

Map<String, dynamic> _$ConfirmVerifyEmailResponseToJson(
        ConfirmVerifyEmailResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
    };

EmailVerificationResponse _$EmailVerificationResponseFromJson(
    Map<String, dynamic> json) {
  return EmailVerificationResponse(
    json['success'] as String,
  );
}

Map<String, dynamic> _$EmailVerificationResponseToJson(
        EmailVerificationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UpdateValueRequest _$UpdateValueRequestFromJson(Map<String, dynamic> json) {
  return UpdateValueRequest(
    json['value'] as String,
  );
}

Map<String, dynamic> _$UpdateValueRequestToJson(UpdateValueRequest instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

UpdateProfilePictureRequest _$UpdateProfilePictureRequestFromJson(
    Map<String, dynamic> json) {
  return UpdateProfilePictureRequest(
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$UpdateProfilePictureRequestToJson(
        UpdateProfilePictureRequest instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
    };

FeedbackRequest _$FeedbackRequestFromJson(Map<String, dynamic> json) {
  return FeedbackRequest(
    json['feedback'] as String,
    json['rating'] as int,
  );
}

Map<String, dynamic> _$FeedbackRequestToJson(FeedbackRequest instance) =>
    <String, dynamic>{
      'feedback': instance.feedback,
      'rating': instance.rating,
    };

UpdateProfilePictureResponse _$UpdateProfilePictureResponseFromJson(
    Map<String, dynamic> json) {
  return UpdateProfilePictureResponse(
    json['detail'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$UpdateProfilePictureResponseToJson(
        UpdateProfilePictureResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'avatar': instance.avatar,
    };

ReportBugRequest _$ReportBugRequestFromJson(Map<String, dynamic> json) {
  return ReportBugRequest(
    json['bug_information'] as String,
  );
}

Map<String, dynamic> _$ReportBugRequestToJson(ReportBugRequest instance) =>
    <String, dynamic>{
      'bug_information': instance.bugInformation,
    };

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) {
  return ErrorModel(
    json['error'] as String,
    (json['details'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'details': instance.details,
    };

DetailOnlyResponse _$DetailOnlyResponseFromJson(Map<String, dynamic> json) {
  return DetailOnlyResponse(
    json['detail'] as String,
  );
}

Map<String, dynamic> _$DetailOnlyResponseToJson(DetailOnlyResponse instance) =>
    <String, dynamic>{
      'detail': instance.detail,
    };

AuthUserResponse _$AuthUserResponseFromJson(Map<String, dynamic> json) {
  return AuthUserResponse(
    json['id'] as int,
    json['email'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['auth_token'] as String,
    json['date_joined'] as String,
    json['country'] as String,
    json['language'] as String,
    json['religion'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$AuthUserResponseToJson(AuthUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'auth_token': instance.authToken,
      'date_joined': instance.dateJoined,
      'country': instance.country,
      'language': instance.language,
      'religion': instance.religion,
      'avatar': instance.avatar,
    };

GenericUserResponse _$GenericUserResponseFromJson(Map<String, dynamic> json) {
  return GenericUserResponse(
    json['id'] as int,
    json['email'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['country'] as String,
    json['language'] as String,
    json['religion'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$GenericUserResponseToJson(
        GenericUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'country': instance.country,
      'language': instance.language,
      'religion': instance.religion,
      'avatar': instance.avatar,
    };

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    json['id'] as int,
    json['country'] as String,
  );
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
    };

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) {
  return LanguageModel(
    json['id'] as int,
    json['language'] as String,
  );
}

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language,
    };

ReligionModel _$ReligionModelFromJson(Map<String, dynamic> json) {
  return ReligionModel(
    json['id'] as int,
    json['religion'] as String,
  );
}

Map<String, dynamic> _$ReligionModelToJson(ReligionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'religion': instance.religion,
    };

AllCountriesResponse _$AllCountriesResponseFromJson(Map<String, dynamic> json) {
  return AllCountriesResponse(
    (json['countries'] as List)
        ?.map((e) =>
            e == null ? null : CountryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllCountriesResponseToJson(
        AllCountriesResponse instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };

AllLanguagesResponse _$AllLanguagesResponseFromJson(Map<String, dynamic> json) {
  return AllLanguagesResponse(
    (json['languages'] as List)
        ?.map((e) => e == null
            ? null
            : LanguageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllLanguagesResponseToJson(
        AllLanguagesResponse instance) =>
    <String, dynamic>{
      'languages': instance.languages,
    };

AllReligionsResponse _$AllReligionsResponseFromJson(Map<String, dynamic> json) {
  return AllReligionsResponse(
    (json['religions'] as List)
        ?.map((e) => e == null
            ? null
            : ReligionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllReligionsResponseToJson(
        AllReligionsResponse instance) =>
    <String, dynamic>{
      'religions': instance.religions,
    };

Thread _$ThreadFromJson(Map<String, dynamic> json) {
  return Thread(
    json['id'] as String,
    json['firstUserId'] as int,
    json['firstUserName'] as String,
    json['firstUserAvatar'] as String,
    json['firstUserUnseenMessageCount'] as int,
    json['secondUserId'] as int,
    json['secondUserName'] as String,
    json['secondUserAvatar'] as String,
    json['secondUserUnseenMessageCount'] as int,
    json['lastMessage'] as String,
    json['lastUpdateTimeStamp'] as int,
    json['firstUserDeleteUntil'] as int,
    json['secondUserDeleteUntil'] as int,
    (json['users'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'id': instance.id,
      'firstUserId': instance.firstUserId,
      'firstUserName': instance.firstUserName,
      'firstUserAvatar': instance.firstUserAvatar,
      'firstUserUnseenMessageCount': instance.firstUserUnseenMessageCount,
      'secondUserId': instance.secondUserId,
      'secondUserName': instance.secondUserName,
      'secondUserAvatar': instance.secondUserAvatar,
      'secondUserUnseenMessageCount': instance.secondUserUnseenMessageCount,
      'lastMessage': instance.lastMessage,
      'lastUpdateTimeStamp': instance.lastUpdateTimeStamp,
      'firstUserDeleteUntil': instance.firstUserDeleteUntil,
      'secondUserDeleteUntil': instance.secondUserDeleteUntil,
      'users': instance.users,
    };

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['threadId'] as String,
    json['senderId'] as int,
    json['sentDate'] as int,
    json['message'] as String,
    json['type'] as int,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'threadId': instance.threadId,
      'senderId': instance.senderId,
      'sentDate': instance.sentDate,
      'message': instance.message,
      'type': instance.type,
    };

GetAllFriendsResponse _$GetAllFriendsResponseFromJson(
    Map<String, dynamic> json) {
  return GetAllFriendsResponse(
    (json['all_friends'] as List)
        ?.map((e) => e == null
            ? null
            : SingleFriendResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetAllFriendsResponseToJson(
        GetAllFriendsResponse instance) =>
    <String, dynamic>{
      'all_friends': instance.allFriends,
    };

SingleFriendResponse _$SingleFriendResponseFromJson(Map<String, dynamic> json) {
  return SingleFriendResponse(
    json['friend'] == null
        ? null
        : GenericUserResponse.fromJson(json['friend'] as Map<String, dynamic>),
    json['friend_since'] as String,
  );
}

Map<String, dynamic> _$SingleFriendResponseToJson(
        SingleFriendResponse instance) =>
    <String, dynamic>{
      'friend': instance.friend,
      'friend_since': instance.friendSince,
    };

SingleSentFriendRequestResponse _$SingleSentFriendRequestResponseFromJson(
    Map<String, dynamic> json) {
  return SingleSentFriendRequestResponse(
    json['id'] as int,
    json['receiver'] == null
        ? null
        : GenericUserResponse.fromJson(
            json['receiver'] as Map<String, dynamic>),
    json['request_send_date'] as String,
  );
}

Map<String, dynamic> _$SingleSentFriendRequestResponseToJson(
        SingleSentFriendRequestResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'receiver': instance.receiver,
      'request_send_date': instance.requestSendDate,
    };

GetAllSentFriendRequestResponse _$GetAllSentFriendRequestResponseFromJson(
    Map<String, dynamic> json) {
  return GetAllSentFriendRequestResponse(
    (json['all_sent_requests'] as List)
        ?.map((e) => e == null
            ? null
            : SingleSentFriendRequestResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetAllSentFriendRequestResponseToJson(
        GetAllSentFriendRequestResponse instance) =>
    <String, dynamic>{
      'all_sent_requests': instance.allSentRequests,
    };

SingleReceivedFriendRequestResponse
    _$SingleReceivedFriendRequestResponseFromJson(Map<String, dynamic> json) {
  return SingleReceivedFriendRequestResponse(
    json['id'] as int,
    json['sender'] == null
        ? null
        : GenericUserResponse.fromJson(json['sender'] as Map<String, dynamic>),
    json['request_send_date'] as String,
  );
}

Map<String, dynamic> _$SingleReceivedFriendRequestResponseToJson(
        SingleReceivedFriendRequestResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'request_send_date': instance.requestSendDate,
    };

GetAllReceivedFriendRequestResponse
    _$GetAllReceivedFriendRequestResponseFromJson(Map<String, dynamic> json) {
  return GetAllReceivedFriendRequestResponse(
    (json['all_received_requests'] as List)
        ?.map((e) => e == null
            ? null
            : SingleReceivedFriendRequestResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetAllReceivedFriendRequestResponseToJson(
        GetAllReceivedFriendRequestResponse instance) =>
    <String, dynamic>{
      'all_received_requests': instance.allReceivedRequests,
    };

GetFriendSuggestionsResponse _$GetFriendSuggestionsResponseFromJson(
    Map<String, dynamic> json) {
  return GetFriendSuggestionsResponse(
    (json['suggestions'] as List)
        ?.map((e) => e == null
            ? null
            : GenericUserResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetFriendSuggestionsResponseToJson(
        GetFriendSuggestionsResponse instance) =>
    <String, dynamic>{
      'suggestions': instance.suggestions,
    };

SearchPeopleRequest _$SearchPeopleRequestFromJson(Map<String, dynamic> json) {
  return SearchPeopleRequest(
    json['search_keyword'] as String,
  );
}

Map<String, dynamic> _$SearchPeopleRequestToJson(
        SearchPeopleRequest instance) =>
    <String, dynamic>{
      'search_keyword': instance.searchKeyword,
    };

SinglePeopleResponse _$SinglePeopleResponseFromJson(Map<String, dynamic> json) {
  return SinglePeopleResponse(
    json['user'] == null
        ? null
        : GenericUserResponse.fromJson(json['user'] as Map<String, dynamic>),
    json['is_friend'] as bool,
  );
}

Map<String, dynamic> _$SinglePeopleResponseToJson(
        SinglePeopleResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'is_friend': instance.isFriend,
    };

SearchPeopleResponse _$SearchPeopleResponseFromJson(Map<String, dynamic> json) {
  return SearchPeopleResponse(
    (json['search_result'] as List)
        ?.map((e) => e == null
            ? null
            : SinglePeopleResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchPeopleResponseToJson(
        SearchPeopleResponse instance) =>
    <String, dynamic>{
      'search_result': instance.searchResult,
    };

GetAllBlockedUsersResponse _$GetAllBlockedUsersResponseFromJson(
    Map<String, dynamic> json) {
  return GetAllBlockedUsersResponse(
    (json['blocked_users'] as List)
        ?.map((e) => e == null
            ? null
            : GenericUserResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetAllBlockedUsersResponseToJson(
        GetAllBlockedUsersResponse instance) =>
    <String, dynamic>{
      'blocked_users': instance.blockedUsers,
    };
