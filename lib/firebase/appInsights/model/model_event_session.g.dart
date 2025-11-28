// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_event_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelEventSession _$ModelEventSessionFromJson(Map<String, dynamic> json) =>
    ModelEventSession(
      sessionStart: DateTime.parse(json['sessionStart'] as String),
      sessionId: json['sessionId'] as String,
      event: $enumDecode(_$AnalyticsEventsEnumMap, json['event']),
      previousSessionId: json['previousSessionId'] as String?,
      sessionEnd: json['sessionEnd'] == null
          ? null
          : DateTime.parse(json['sessionEnd'] as String),
      sessionDurationInSeconds: (json['sessionDurationInSeconds'] as num?)
          ?.toInt(),
    )..eventTime = json['eventTime'] as String;

Map<String, dynamic> _$ModelEventSessionToJson(ModelEventSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'event': _$AnalyticsEventsEnumMap[instance.event]!,
      'eventTime': instance.eventTime,
      'previousSessionId': instance.previousSessionId,
      'sessionStart': instance.sessionStart.toIso8601String(),
      'sessionEnd': instance.sessionEnd?.toIso8601String(),
      'sessionDurationInSeconds': instance.sessionDurationInSeconds,
    };

const _$AnalyticsEventsEnumMap = {
  AnalyticsEvents.session_change_user_data: 'session_change_user_data',
  AnalyticsEvents.session_start_app: 'session_start_app',
  AnalyticsEvents.session_end_app: 'session_end_app',
  AnalyticsEvents.app_state_open: 'app_state_open',
  AnalyticsEvents.app_state_background: 'app_state_background',
  AnalyticsEvents.app_state_resume: 'app_state_resume',
  AnalyticsEvents.app_state_close: 'app_state_close',
  AnalyticsEvents.login_input_number: 'login_input_number',
  AnalyticsEvents.login_success: 'login_success',
  AnalyticsEvents.login_failure: 'login_failure',
  AnalyticsEvents.logout: 'logout',
  AnalyticsEvents.preferences_set: 'preferences_set',
  AnalyticsEvents.view_feed: 'view_feed',
  AnalyticsEvents.post_impression: 'post_impression',
  AnalyticsEvents.post_view: 'post_view',
  AnalyticsEvents.post_emoji: 'post_emoji',
  AnalyticsEvents.post_un_emoji: 'post_un_emoji',
  AnalyticsEvents.post_like: 'post_like',
  AnalyticsEvents.post_un_like: 'post_un_like',
  AnalyticsEvents.post_dislike: 'post_dislike',
  AnalyticsEvents.post_un_dislike: 'post_un_dislike',
  AnalyticsEvents.post_bookmark: 'post_bookmark',
  AnalyticsEvents.post_un_bookmark: 'post_un_bookmark',
  AnalyticsEvents.post_pin: 'post_pin',
  AnalyticsEvents.post_un_pin: 'post_un_pin',
  AnalyticsEvents.post_download: 'post_download',
  AnalyticsEvents.post_share: 'post_share',
  AnalyticsEvents.post_report: 'post_report',
  AnalyticsEvents.event_going: 'event_going',
  AnalyticsEvents.event_not_going: 'event_not_going',
  AnalyticsEvents.event_uncertain: 'event_uncertain',
  AnalyticsEvents.comment_screen_open: 'comment_screen_open',
  AnalyticsEvents.comment_screen_close: 'comment_screen_close',
  AnalyticsEvents.comment_add: 'comment_add',
  AnalyticsEvents.comment_delete: 'comment_delete',
  AnalyticsEvents.reaction_add: 'reaction_add',
  AnalyticsEvents.reaction_remove: 'reaction_remove',
  AnalyticsEvents.user_share: 'user_share',
  AnalyticsEvents.follow_user: 'follow_user',
  AnalyticsEvents.unfollow_user: 'unfollow_user',
  AnalyticsEvents.follow_community: 'follow_community',
  AnalyticsEvents.unfollow_community: 'unfollow_community',
  AnalyticsEvents.open_profile: 'open_profile',
  AnalyticsEvents.detail_screen_view_content: 'detail_screen_view_content',
  AnalyticsEvents.detail_screen_view_open: 'detail_screen_view_open',
  AnalyticsEvents.detail_screen_view_next_content:
      'detail_screen_view_next_content',
  AnalyticsEvents.detail_screen_view_previous_content:
      'detail_screen_view_previous_content',
  AnalyticsEvents.detail_screen_view_close: 'detail_screen_view_close',
  AnalyticsEvents.feed_screen_scroll_view_open: 'feed_screen_scroll_view_open',
  AnalyticsEvents.feed_screen_scroll_view_close:
      'feed_screen_scroll_view_close',
  AnalyticsEvents.community_screen_open: 'community_screen_open',
  AnalyticsEvents.community_screen_close: 'community_screen_close',
  AnalyticsEvents.shorts_view: 'shorts_view',
  AnalyticsEvents.shorts_complete: 'shorts_complete',
  AnalyticsEvents.video_play_initialized: 'video_play_initialized',
  AnalyticsEvents.video_play_playing: 'video_play_playing',
  AnalyticsEvents.video_play_pause: 'video_play_pause',
  AnalyticsEvents.video_play_seek: 'video_play_seek',
  AnalyticsEvents.video_play_complete: 'video_play_complete',
  AnalyticsEvents.create_feed_created: 'create_feed_created',
  AnalyticsEvents.create_feed_open: 'create_feed_open',
  AnalyticsEvents.create_feed_close: 'create_feed_close',
  AnalyticsEvents.upload_image_start: 'upload_image_start',
  AnalyticsEvents.upload_image_complete: 'upload_image_complete',
  AnalyticsEvents.upload_video_start: 'upload_video_start',
  AnalyticsEvents.upload_video_complete: 'upload_video_complete',
  AnalyticsEvents.search_query: 'search_query',
  AnalyticsEvents.profile_self_screen_open: 'profile_self_screen_open',
  AnalyticsEvents.profile_self_screen_close: 'profile_self_screen_close',
  AnalyticsEvents.profile_other_screen_open: 'profile_other_screen_open',
  AnalyticsEvents.profile_other_screen_close: 'profile_other_screen_close',
  AnalyticsEvents.notification_received: 'notification_received',
  AnalyticsEvents.notification_open: 'notification_open',
  AnalyticsEvents.app_theme_change: 'app_theme_change',
  AnalyticsEvents.track_screen_navigation: 'track_screen_navigation',
  AnalyticsEvents.track_screen_route: 'track_screen_route',
  AnalyticsEvents.contact_invite_sent: 'contact_invite_sent',
  AnalyticsEvents.contact_permission_accepted: 'contact_permission_accepted',
  AnalyticsEvents.contact_permission_rejected: 'contact_permission_rejected',
  AnalyticsEvents.location_permission_accepted: 'location_permission_accepted',
  AnalyticsEvents.location_permission_rejected: 'location_permission_rejected',
  AnalyticsEvents.app_crash: 'app_crash',
  AnalyticsEvents.network_error: 'network_error',
  AnalyticsEvents.ui_error: 'ui_error',
  AnalyticsEvents.none: 'none',
};
