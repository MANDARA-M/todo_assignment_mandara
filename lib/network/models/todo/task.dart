import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inSTA/utilities/storage/shared_preference/shared_preferences_util.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../converters/timestamp_converter.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task({
    required this.uid,
    required this.ownerId,
    required this.ownerName,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.isCompleted = false,
    this.sharedWith = const [],
  });

  final String uid;
  final String ownerId;
  final String ownerName;
  final String title;
  final String description;

  @TimestampConverter()
  DateTime? createdAt;

  @TimestampConverter()
  DateTime? updatedAt;
  bool isCompleted;
  final List<String> sharedWith;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task newTask({required String title, required String description}) {
    final uid = Uuid().v4();
    final ownerId = SharedPreferencesUtil.instance.userId;
    final ownerName = SharedPreferencesUtil.instance.userName;

    return Task(
      uid: uid,
      ownerId: ownerId,
      ownerName: ownerName,
      title: title,
      description: description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isCompleted: false,
      sharedWith: [],
    );
  }
}
