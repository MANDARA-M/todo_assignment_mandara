// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_otp_resend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseOtpResend _$ResponseOtpResendFromJson(Map<String, dynamic> json) =>
    ResponseOtpResend(
        data: ResponseOtpResendData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
      )
      ..code = (json['code'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..success = json['success'] as bool?;

Map<String, dynamic> _$ResponseOtpResendToJson(ResponseOtpResend instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };

ResponseOtpResendData _$ResponseOtpResendDataFromJson(
  Map<String, dynamic> json,
) => ResponseOtpResendData(
  resultSet: json['resultSet'] == null
      ? null
      : ItemOtpResend.fromJson(json['resultSet'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResponseOtpResendDataToJson(
  ResponseOtpResendData instance,
) => <String, dynamic>{'resultSet': instance.resultSet};
