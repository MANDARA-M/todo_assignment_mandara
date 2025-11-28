import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse {
  CommonResponse({
    this.code,
    this.message,
    this.success,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson(json);

  int? code;
  String? message;
  bool? success;

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);

  bool get isSuccess => code == 200 || (success ?? false);
}
