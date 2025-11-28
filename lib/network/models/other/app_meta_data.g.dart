// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppMetaData _$AppMetaDataFromJson(Map<String, dynamic> json) => AppMetaData(
  isOnBoardingCompleted: json['isOnBoardingCompleted'] as bool? ?? false,
  isAppFirstTimeLaunch: json['isAppFirstTimeLaunch'] as bool? ?? true,
);

Map<String, dynamic> _$AppMetaDataToJson(AppMetaData instance) =>
    <String, dynamic>{
      'isOnBoardingCompleted': instance.isOnBoardingCompleted,
      'isAppFirstTimeLaunch': instance.isAppFirstTimeLaunch,
    };
