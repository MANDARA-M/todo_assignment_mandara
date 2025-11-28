// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseUser _$ResponseUserFromJson(Map<String, dynamic> json) =>
    ResponseUser(
        data: ResponseUserData.fromJson(json['data'] as Map<String, dynamic>),
      )
      ..code = (json['code'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$ResponseUserToJson(ResponseUser instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };

ResponseUserData _$ResponseUserDataFromJson(Map<String, dynamic> json) =>
    ResponseUserData(
      resultSet: User.fromJson(json['resultSet'] as Map<String, dynamic>),
      token: json['token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$ResponseUserDataToJson(ResponseUserData instance) =>
    <String, dynamic>{
      'resultSet': instance.resultSet,
      'token': instance.token,
      'refresh_token': instance.refreshToken,
    };
