import 'package:json_annotation/json_annotation.dart';

part 'item_otp_resend.g.dart';

@JsonSerializable()
class ItemOtpResend {
  ItemOtpResend({
    required this.mobileNumber,
    this.resendTime,
    this.maximumRetry,
  });

  factory ItemOtpResend.fromJson(Map<String, dynamic> json) => _$ItemOtpResendFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOtpResendToJson(this);

  @JsonKey(name: 'mobile_number')
  String mobileNumber;

  @JsonKey(name: 'resend_time')
  int? resendTime;

  @JsonKey(name: 'maximum_retry')
  int? maximumRetry;
}
