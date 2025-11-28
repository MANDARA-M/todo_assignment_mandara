import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.userId,
    required this.mobile,
    required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  int userId;
  String mobile;
  String? userName;

  String get userNameFormatted => userName ?? '';

  bool get isLogin => userId > 0;

  Map<String, dynamic> toMapShare() {
    return {
      'userId': userId,
      'mobile': mobile,
      'userName': userName,
    };
  }
}
