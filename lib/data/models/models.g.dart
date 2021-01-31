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
