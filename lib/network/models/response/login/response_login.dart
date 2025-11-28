import 'package:json_annotation/json_annotation.dart';

import '../common/common_response.dart';
import 'item_login.dart';

part 'response_login.g.dart';

@JsonSerializable()
class ResponseLogin extends CommonResponse {
  ResponseLogin({
    required this.data,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => _$ResponseLoginFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseLoginToJson(this);

  ResponseLoginData data;

  String get mobileNumber => data.resultSet?.mobileNumber ?? '';
}

@JsonSerializable()
class ResponseLoginData {
  ResponseLoginData({
    required this.resultSet,
  });

  factory ResponseLoginData.fromJson(Map<String, dynamic> json) => _$ResponseLoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginDataToJson(this);

  final ItemLogin? resultSet;
}
