// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  uid: json['uid'] as String,
  ownerId: json['ownerId'] as String,
  ownerName: json['ownerName'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  isCompleted: json['isCompleted'] as bool? ?? false,
  sharedWith:
      (json['sharedWith'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'uid': instance.uid,
  'ownerId': instance.ownerId,
  'ownerName': instance.ownerName,
  'title': instance.title,
  'description': instance.description,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'isCompleted': instance.isCompleted,
  'sharedWith': instance.sharedWith,
};
