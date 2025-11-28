// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_otp_resend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOtpResend _$ItemOtpResendFromJson(Map<String, dynamic> json) =>
    ItemOtpResend(
      mobileNumber: json['mobile_number'] as String,
      resendTime: (json['resend_time'] as num?)?.toInt(),
      maximumRetry: (json['maximum_retry'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemOtpResendToJson(ItemOtpResend instance) =>
    <String, dynamic>{
      'mobile_number': instance.mobileNumber,
      'resend_time': instance.resendTime,
      'maximum_retry': instance.maximumRetry,
    };
