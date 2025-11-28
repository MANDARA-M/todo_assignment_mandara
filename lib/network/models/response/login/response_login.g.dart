// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLogin _$ResponseLoginFromJson(Map<String, dynamic> json) =>
    ResponseLogin(
        data: ResponseLoginData.fromJson(json['data'] as Map<String, dynamic>),
      )
      ..code = (json['code'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$ResponseLoginToJson(ResponseLogin instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };

ResponseLoginData _$ResponseLoginDataFromJson(Map<String, dynamic> json) =>
    ResponseLoginData(
      resultSet: json['resultSet'] == null
          ? null
          : ItemLogin.fromJson(json['resultSet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseLoginDataToJson(ResponseLoginData instance) =>
    <String, dynamic>{'resultSet': instance.resultSet};
