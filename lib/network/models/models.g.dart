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
