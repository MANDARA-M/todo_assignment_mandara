import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inSTA/enums/app_enums.dart';
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
    this.category,
    this.emoji,
    this.createdAt,
    this.updatedAt,
    this.isCompleted = false,
    this.sharedWith = const [],
  });

  String uid;
  String ownerId;
  String ownerName;
  String title;
  String description;
  String? category;
  String? emoji;

  @TimestampConverter()
  DateTime? createdAt;

  @TimestampConverter()
  DateTime? updatedAt;
  bool isCompleted;
  List<String> sharedWith;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  int get userCount => sharedWith.length + 1;

  TaskStatus get taskStatus => TaskStatus.fromBool(isCompleted);

  Task update({required String title, required String description, required String? category, required String? emoji}) {
    this.title = title;
    this.description = description;
    this.category = category;
    this.emoji = emoji;

    return this;
  }

  static Task newTask({required String title, required String description, required String? category, required String? emoji}) {
    final uid = Uuid().v4();
    final ownerId = SharedPreferencesUtil.instance.userId;
    final ownerName = SharedPreferencesUtil.instance.userName;

    return Task(
      uid: uid,
      ownerId: ownerId,
      ownerName: ownerName,
      title: title,
      description: description,
      category: category,
      emoji: emoji,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isCompleted: false,
      sharedWith: [],
    );
  }

  void toggleCompleted() => isCompleted = !isCompleted;
}
