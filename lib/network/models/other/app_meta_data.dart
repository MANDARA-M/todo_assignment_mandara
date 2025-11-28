import 'package:json_annotation/json_annotation.dart';

part 'app_meta_data.g.dart';

@JsonSerializable()
class AppMetaData {
  AppMetaData({this.isOnBoardingCompleted = false, this.isAppFirstTimeLaunch = true});

  factory AppMetaData.fromJson(Map<String, dynamic> json) => _$AppMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppMetaDataToJson(this);

  bool isOnBoardingCompleted;
  bool isAppFirstTimeLaunch;
}
