import 'package:json_annotation/json_annotation.dart';

import '../common/common_response.dart';
import 'user.dart';

part 'response_user.g.dart';

@JsonSerializable()
class ResponseUser extends CommonResponse {
  ResponseUser({
    required this.data,
  });

  factory ResponseUser.fromJson(Map<String, dynamic> json) => _$ResponseUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseUserToJson(this);

  ResponseUserData data;

  User get user => data.resultSet;
}

@JsonSerializable()
class ResponseUserData {
  ResponseUserData({
    required this.resultSet,
    this.token,
    this.refreshToken,
  });

  factory ResponseUserData.fromJson(Map<String, dynamic> json) => _$ResponseUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserDataToJson(this);

  User resultSet;

  String? token;

  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  User get user => resultSet;

  bool get isUserLoggedIn => user.isLogin;

  // user setter
  Future<void> setUser(User user) async {
    resultSet = user;
  }
}
