import 'package:json_annotation/json_annotation.dart';

import '../../../enums/app_enums_analytics.dart';

part 'model_track_event.g.dart';

@JsonSerializable()
class ModelTrackEvent {
  ModelTrackEvent({
    required this.event,
    required this.eventProperties,
  });

  factory ModelTrackEvent.fromJson(Map<String, dynamic> json) => _$ModelTrackEventFromJson(json);

  Map<String, dynamic> toJson() => _$ModelTrackEventToJson(this);

  final AnalyticsEvents event;
  final Map<String, dynamic> eventProperties;
}
