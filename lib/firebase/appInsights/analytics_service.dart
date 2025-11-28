import 'dart:async';

import 'package:uuid/uuid.dart';

import '../../enums/app_enums_analytics.dart';
import '../../utilities/print_util.dart';
import '../../utilities/storage/shared_preference/shared_preferences_util.dart';
import 'firebase_logger.dart';
import 'model/model_event_common.dart';
import 'model/model_event_session.dart';
import 'model/model_track_event.dart';

class SimplePersistentQueue {
  final List<ModelTrackEvent> _store = [];

  Future<void> appendBatch(List<ModelTrackEvent> events) async {
    _store.addAll(events);
  }

  Future<List<ModelTrackEvent>> readAll() async => List.from(_store);

  Future<void> clear() async => _store.clear();
}

class AnalyticsService {
  AnalyticsService._() {
    _analyticsTimer = Timer.periodic(kTimeSend, (_) => _persistAndFlush());
    _sessionTimer = Timer.periodic(const Duration(minutes: 10), (_) => _closeSession());
    _startSession();
  }

  static AnalyticsService? _instance;
  static final AnalyticsService instance = _instance ??= AnalyticsService._();

  final uuid = const Uuid();
  int kBatchMaxEvents = 500;
  Duration kTimeSend = const Duration(minutes: 5);

  final List<ModelTrackEvent> _buffer = [];
  final SimplePersistentQueue _queue = SimplePersistentQueue();
  Timer? _analyticsTimer;
  Timer? _sessionTimer;
  ModelEventSession? _session;

  String get sessionId => _session?.sessionId ?? '';

  void appResumed() {
    _startSession();
  }

  void appInactive() {
    _closeSession();
  }

  void _startSession() {
    if (_session?.isSessionEnded ?? true) {
      _session = ModelEventSession.getSessionStart();
      PrintUtils.instance.printInformation('Session -> Start: ${_session?.toJson()}');
      _trackSession(event: AnalyticsEvents.session_start_app);
    }
  }

  void _closeSession() {
    if (!(_session?.isSessionEnded ?? false)) {
      _session?.endSession();
      PrintUtils.instance.printInformation('Session -> End: ${_session?.toJson()}');
      _trackSession(event: AnalyticsEvents.session_end_app);
      _persistAndFlush();
    }
  }

  void _trackSession({required AnalyticsEvents event}) {
    trackEntryEvent(event: event, eventProperties: _session?.toJson() ?? {});
  }

  void trackEntryEvent({required AnalyticsEvents event, required Map<String, dynamic> eventProperties}) {
    final commonEventMap = ModelEventCommon.getJsonMap(sessionId: sessionId, event: event);
    eventProperties.addAll(commonEventMap);

    _trackEvent(event: event, eventProperties: eventProperties);
  }

  void _trackEvent({required AnalyticsEvents event, required Map<String, dynamic> eventProperties}) {
    if (sessionId.isEmpty) {
      _startSession();
    }

    final trackEvent = ModelTrackEvent(event: event, eventProperties: eventProperties);

    _executeFinalLogging(pendingEvent: trackEvent);
  }

  Future<void> _persistAndFlush() async {
    if (_buffer.isEmpty) {
      return;
    }
    final toPersist = List<ModelTrackEvent>.from(_buffer);
    await _queue.appendBatch(toPersist);
    _buffer.clear();
    await _flush(); // attempt send immediately
  }

  Future<void> _flush() async {
    // load queued events first
    final pending = await _queue.readAll();
    if (pending.isEmpty) {
      return;
    }
    for (var index = 0; index < pending.length; index++) {
      final pendingEvent = pending[index];
      _executeFinalLogging(pendingEvent: pendingEvent);
    }

    await _queue.clear();
  }

  void _executeFinalLogging({required ModelTrackEvent pendingEvent}) {
    final event = pendingEvent.event;
    final eventProperties = pendingEvent.eventProperties;

    eventProperties.removeWhere((key, value) => value == null);
    //final parameters = eventProperties.map((key, value) => MapEntry(key, value != null ? value as Object : Object()));
    final parameters = eventProperties.map((key, value) => MapEntry(key, value != null ? value.toString() : ''));

    FirebaseLogger.instance.logEvent(event.name, parameters: parameters);
  }

  void dispose() {
    _analyticsTimer?.cancel();
    _sessionTimer?.cancel();
  }
}
