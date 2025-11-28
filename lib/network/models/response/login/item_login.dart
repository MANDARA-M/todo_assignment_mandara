import 'package:json_annotation/json_annotation.dart';

part 'item_login.g.dart';

@JsonSerializable()
class ItemLogin {
  ItemLogin({
    required this.mobileNumber,
  });

  factory ItemLogin.fromJson(Map<String, dynamic> json) => _$ItemLoginFromJson(json);

  Map<String, dynamic> toJson() => _$ItemLoginToJson(this);

  @JsonKey(name: 'mobile_number')
  String mobileNumber;
}
