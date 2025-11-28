import 'package:json_annotation/json_annotation.dart';

import '../common/common_response.dart';
import 'item_otp_resend.dart';

part 'response_otp_resend.g.dart';

@JsonSerializable()
class ResponseOtpResend extends CommonResponse {
  ResponseOtpResend({
    required this.data,
  });

  factory ResponseOtpResend.fromJson(Map<String, dynamic> json) => _$ResponseOtpResendFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseOtpResendToJson(this);

  ResponseOtpResendData data;

  String get mobileNumber => data.resultSet?.mobileNumber ?? '';

  int? get resendTime => data.resultSet?.resendTime;

  int? get maximumRetry => data.resultSet?.maximumRetry;
}

@JsonSerializable()
class ResponseOtpResendData {
  ResponseOtpResendData({
    required this.resultSet,
  });

  factory ResponseOtpResendData.fromJson(Map<String, dynamic> json) => _$ResponseOtpResendDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseOtpResendDataToJson(this);

  final ItemOtpResend? resultSet;
}
