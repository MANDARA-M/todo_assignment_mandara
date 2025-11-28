import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../enums/app_enums_analytics.dart';
import 'model_event_common.dart';

part 'model_event_session.g.dart';

@JsonSerializable()
class ModelEventSession extends ModelEventCommon {
  ModelEventSession({
    required this.sessionStart,
    required super.sessionId,
    required super.event,
    this.previousSessionId,
    this.sessionEnd,
    this.sessionDurationInSeconds,
  });

  factory ModelEventSession.fromJson(Map<String, dynamic> json) => _$ModelEventSessionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ModelEventSessionToJson(this);

  final String? previousSessionId;
  final DateTime sessionStart;
  DateTime? sessionEnd;
  int? sessionDurationInSeconds;

  bool get isSessionActive => sessionEnd == null;
  bool get isSessionEnded => sessionEnd != null;

  static ModelEventSession getSessionStart({String? previousSessionId}) {
    return ModelEventSession(
      sessionStart: DateTime.now(),
      sessionId: const Uuid().v4(),
      event: AnalyticsEvents.session_start_app,
      previousSessionId: previousSessionId,
    );
  }

  void endSession() {
    sessionEnd = DateTime.now();
    sessionDurationInSeconds = sessionEnd!.difference(sessionStart).inSeconds;
  }
}
