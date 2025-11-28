

class AppEnumsAnalytics {}

enum AnalyticsPriority {
  low(priority: 1, text: 'Low'),
  medium(priority: 2, text: 'Medium'),
  high(priority: 3, text: 'High', isImmediateLog: true),
  critical(priority: 3, text: 'Critical', isImmediateLog: true);

  const AnalyticsPriority({required this.priority, required this.text, this.isImmediateLog = false});

  final int priority;
  final String text;
  final bool isImmediateLog;
}

enum AnalyticsType {
  technical(type: 'technical'),
  business(type: 'business');

  const AnalyticsType({
    required this.type,
    this.isEnabled = true,
  });

  final String type;
  final bool isEnabled;
}

enum AnalyticsEvents {
  session_change_user_data(priority: AnalyticsPriority.critical),
  session_start_app(priority: AnalyticsPriority.critical),
  session_end_app(priority: AnalyticsPriority.critical),
  app_state_open,
  app_state_background,
  app_state_resume,
  app_state_close,
  login_input_number,
  login_success,
  login_failure,
  logout,
  preferences_set,
  view_feed,
  post_impression,
  post_view,
  post_emoji,
  post_un_emoji,
  post_like,
  post_un_like,
  post_dislike,
  post_un_dislike,
  post_bookmark,
  post_un_bookmark,
  post_pin,
  post_un_pin,
  post_download,
  post_share,
  post_report,
  event_going,
  event_not_going,
  event_uncertain,
  comment_screen_open,
  comment_screen_close,
  comment_add,
  comment_delete,
  reaction_add,
  reaction_remove,
  user_share,
  follow_user,
  unfollow_user,
  follow_community,
  unfollow_community,
  open_profile,
  detail_screen_view_content,
  detail_screen_view_open,
  detail_screen_view_next_content,
  detail_screen_view_previous_content,
  detail_screen_view_close,
  feed_screen_scroll_view_open,
  feed_screen_scroll_view_close,
  community_screen_open,
  community_screen_close,
  shorts_view,
  shorts_complete,
  video_play_initialized,
  video_play_playing,
  video_play_pause,
  video_play_seek,
  video_play_complete,
  create_feed_created,
  create_feed_open,
  create_feed_close,
  upload_image_start,
  upload_image_complete,
  upload_video_start,
  upload_video_complete,
  search_query,
  profile_self_screen_open,
  profile_self_screen_close,
  profile_other_screen_open,
  profile_other_screen_close,
  notification_received,
  notification_open,
  app_theme_change,
  track_screen_navigation,
  track_screen_route,
  contact_invite_sent,
  contact_permission_accepted,
  contact_permission_rejected,
  location_permission_accepted,
  location_permission_rejected,
  app_crash(priority: AnalyticsPriority.high),
  network_error(priority: AnalyticsPriority.high),
  ui_error(priority: AnalyticsPriority.high),
  none;


  const AnalyticsEvents({this.priority = AnalyticsPriority.medium});

  final AnalyticsPriority priority;


  bool get isImmediateLog => priority.isImmediateLog;

  Map<String, dynamic> get toMap {
    return {
      'event': name,
      'priority': priority.priority,
      'text': priority.text,
    };
  }
}
