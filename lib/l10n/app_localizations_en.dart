// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get create => 'Create';

  @override
  String get chart => 'Chart';

  @override
  String get profile => 'Profile';

  @override
  String get created => 'Created';

  @override
  String get joined => 'Joined';

  @override
  String get createNewTask => 'create New Task';

  @override
  String get fetchTask => 'Fetch Task';

  @override
  String get joinTask => 'Join Task';

  @override
  String get addIconToTask => 'Add Icon to Task';

  @override
  String get addTaskTitle => 'Add task by ID';

  @override
  String get addTaskDescription =>
      'You can add task by task id shared with you by anyone, It\'s simple and quick. Try searching the task and add quickly.\n\nNote: Any changes you gonna do in joined task will reflect to other user who are sharing the task.';

  @override
  String get sharePostText => 'Join the task and collab:\n\nTask ID: %s';

  @override
  String get toastErrorNoTaskFound => 'No Task Found by given ID';

  @override
  String get toastErrorTaskOwner => 'You are already owner of task';

  @override
  String get toastErrorTaskAlreadyJoined =>
      'You already joined the task, please join another task';

  @override
  String get toastSuccessJoined => 'Task Joined successfully!!';

  @override
  String get signInWithMobile => 'Sign in with mobile number';

  @override
  String get onboardingTitle1Screen1 => 'Welcome to';

  @override
  String get onboardingTitle2Screen1 => 'Todo-Task';

  @override
  String get onboardingSubTitle1Screen1 =>
      'Swadeshi platform built for the world. Connect with like-minded people, exchange perspectives, and celebrate identity together.';

  @override
  String get onboardingTitle1Screen2 => 'Built';

  @override
  String get onboardingTitle2Screen2 => 'Indian';

  @override
  String get onboardingSubTitle1Screen2 =>
      'Share your thoughts, ideas, and stories. From culture to creativity, discover a safe space where your voice finds connection and respect.';

  @override
  String get onboardingTitle1Screen5 => 'Do More, Like Never';

  @override
  String get onboardingTitle2Screen5 => 'Before';

  @override
  String get onboardingSubTitle1Screen5 =>
      'Be part of a community that values both tradition and modern life. Express yourself freely while staying connected to shared roots.';

  @override
  String get onboardingTitle1Screen4 => 'Discover the';

  @override
  String get onboardingTitle2Screen4 => 'Spirit';

  @override
  String get onboardingSubTitle1Screen4 =>
      'Explore trending conversations, cultural insights, and community voices. Travel beyond borders with ideas that unite people everywhere.';

  @override
  String get onboardingTitle1Screen3 => 'Share';

  @override
  String get onboardingTitle2Screen3 => 'Tasks';

  @override
  String get onboardingSubTitle1Screen3 =>
      'Share tasks and achieve more, like never before';

  @override
  String get internetNotConnected =>
      'You don’t have an internet connection, or your signal is too low.';

  @override
  String get wewillsendyouconfirmationcode =>
      'We will send you confirmation code';

  @override
  String get enteryourmobilenumber => 'Enter your \nmobile number';

  @override
  String get weSentItToNumber => 'We sent it to number +91';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get countryCode => '+91';

  @override
  String get enterCodeSendToYourPhone => 'Enter code \nsend to your phone';

  @override
  String get next => 'Next';

  @override
  String get limitReachedForOtp => 'Limit reached for OTP resend.';

  @override
  String get resendCodeIn => 'Resend code in';

  @override
  String get verify => 'Verify';

  @override
  String get youWentOffline => 'You went offline';

  @override
  String get youWentOfflineSupportText =>
      'It seems you don’t have an internet connection, or your signal is too low.';

  @override
  String get errorEmptyInput => 'Field can not be empty!';

  @override
  String get ok => 'ok';
}
