import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../enums/app_enums_analytics.dart';

part 'model_event_common.g.dart';

@JsonSerializable()
class ModelEventCommon {
  ModelEventCommon({
    required this.sessionId,
    required this.event,
  });

  factory ModelEventCommon.fromJson(Map<String, dynamic> json) => _$ModelEventCommonFromJson(json);

  Map<String, dynamic> toJson() => _$ModelEventCommonToJson(this);

  final String eventId = const Uuid().v4();
  final String sessionId;
  final AnalyticsEvents event;
  String eventTime = DateTime.now().toUtc().toIso8601String();

  static Map<String, dynamic> getJsonMap({required String sessionId, required AnalyticsEvents event}) {
    final model = ModelEventCommon(sessionId: sessionId, event: event);

    final modelParameters = model.toJson();
    final eventMap = event.toMap;
    final mergedMap = <String, dynamic>{...modelParameters, ...eventMap};
    return mergedMap;
  }
}
