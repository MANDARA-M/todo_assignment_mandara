// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  userId: (json['userId'] as num).toInt(),
  mobile: json['mobile'] as String,
  userName: json['userName'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'userId': instance.userId,
  'mobile': instance.mobile,
  'userName': instance.userName,
};
