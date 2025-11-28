
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  final String id;
  final String ownerId;
  final String title;
  final String description;
   Timestamp? createdAt;
   Timestamp? updatedAt;
  bool isCompleted;
  final List<String> sharedWith;


  Task({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.isCompleted = false,
    this.sharedWith = const [],
  });


  Task copyWith({
    String? id,
    String? ownerId,
    String? title,
    String? description,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    bool? isCompleted,
    List<String>? sharedWith,
  }) {
    return Task(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCompleted: isCompleted ?? this.isCompleted,
      sharedWith: sharedWith ?? this.sharedWith,
    );
  }

  factory Task.fromMap(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isCompleted: json['isCompleted'] ?? false,
      sharedWith: List<String>.from(json['sharedWith'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isCompleted': isCompleted,
      'sharedWith': sharedWith,
    };
  }

}