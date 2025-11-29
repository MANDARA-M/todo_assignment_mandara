import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @chart.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get chart;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @createNewTask.
  ///
  /// In en, this message translates to:
  /// **'create New Task'**
  String get createNewTask;

  /// No description provided for @fetchTask.
  ///
  /// In en, this message translates to:
  /// **'Fetch Task'**
  String get fetchTask;

  /// No description provided for @joinTask.
  ///
  /// In en, this message translates to:
  /// **'Join Task'**
  String get joinTask;

  /// No description provided for @addIconToTask.
  ///
  /// In en, this message translates to:
  /// **'Add Icon to Task'**
  String get addIconToTask;

  /// No description provided for @addTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Add task by ID'**
  String get addTaskTitle;

  /// No description provided for @addTaskDescription.
  ///
  /// In en, this message translates to:
  /// **'You can add task by task id shared with you by anyone, It\'s simple and quick. Try searching the task and add quickly.\n\nNote: Any changes you gonna do in joined task will reflect to other user who are sharing the task.'**
  String get addTaskDescription;

  /// No description provided for @sharePostText.
  ///
  /// In en, this message translates to:
  /// **'Join the task and collab:\n\nTask ID: %s'**
  String get sharePostText;

  /// No description provided for @toastErrorNoTaskFound.
  ///
  /// In en, this message translates to:
  /// **'No Task Found by given ID'**
  String get toastErrorNoTaskFound;

  /// No description provided for @toastErrorTaskOwner.
  ///
  /// In en, this message translates to:
  /// **'You are already owner of task'**
  String get toastErrorTaskOwner;

  /// No description provided for @toastErrorTaskAlreadyJoined.
  ///
  /// In en, this message translates to:
  /// **'You already joined the task, please join another task'**
  String get toastErrorTaskAlreadyJoined;

  /// No description provided for @toastSuccessJoined.
  ///
  /// In en, this message translates to:
  /// **'Task Joined successfully!!'**
  String get toastSuccessJoined;

  /// No description provided for @signInWithMobile.
  ///
  /// In en, this message translates to:
  /// **'Sign in with mobile number'**
  String get signInWithMobile;

  /// No description provided for @onboardingTitle1Screen1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get onboardingTitle1Screen1;

  /// No description provided for @onboardingTitle2Screen1.
  ///
  /// In en, this message translates to:
  /// **'Todo-Task'**
  String get onboardingTitle2Screen1;

  /// No description provided for @onboardingSubTitle1Screen1.
  ///
  /// In en, this message translates to:
  /// **'Swadeshi platform built for the world. Connect with like-minded people, exchange perspectives, and celebrate identity together.'**
  String get onboardingSubTitle1Screen1;

  /// No description provided for @onboardingTitle1Screen2.
  ///
  /// In en, this message translates to:
  /// **'Built'**
  String get onboardingTitle1Screen2;

  /// No description provided for @onboardingTitle2Screen2.
  ///
  /// In en, this message translates to:
  /// **'Indian'**
  String get onboardingTitle2Screen2;

  /// No description provided for @onboardingSubTitle1Screen2.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts, ideas, and stories. From culture to creativity, discover a safe space where your voice finds connection and respect.'**
  String get onboardingSubTitle1Screen2;

  /// No description provided for @onboardingTitle1Screen5.
  ///
  /// In en, this message translates to:
  /// **'Do More, Like Never'**
  String get onboardingTitle1Screen5;

  /// No description provided for @onboardingTitle2Screen5.
  ///
  /// In en, this message translates to:
  /// **'Before'**
  String get onboardingTitle2Screen5;

  /// No description provided for @onboardingSubTitle1Screen5.
  ///
  /// In en, this message translates to:
  /// **'Be part of a community that values both tradition and modern life. Express yourself freely while staying connected to shared roots.'**
  String get onboardingSubTitle1Screen5;

  /// No description provided for @onboardingTitle1Screen4.
  ///
  /// In en, this message translates to:
  /// **'Discover the'**
  String get onboardingTitle1Screen4;

  /// No description provided for @onboardingTitle2Screen4.
  ///
  /// In en, this message translates to:
  /// **'Spirit'**
  String get onboardingTitle2Screen4;

  /// No description provided for @onboardingSubTitle1Screen4.
  ///
  /// In en, this message translates to:
  /// **'Explore trending conversations, cultural insights, and community voices. Travel beyond borders with ideas that unite people everywhere.'**
  String get onboardingSubTitle1Screen4;

  /// No description provided for @onboardingTitle1Screen3.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get onboardingTitle1Screen3;

  /// No description provided for @onboardingTitle2Screen3.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get onboardingTitle2Screen3;

  /// No description provided for @onboardingSubTitle1Screen3.
  ///
  /// In en, this message translates to:
  /// **'Share tasks and achieve more, like never before'**
  String get onboardingSubTitle1Screen3;

  /// No description provided for @internetNotConnected.
  ///
  /// In en, this message translates to:
  /// **'You don’t have an internet connection, or your signal is too low.'**
  String get internetNotConnected;

  /// No description provided for @wewillsendyouconfirmationcode.
  ///
  /// In en, this message translates to:
  /// **'We will send you confirmation code'**
  String get wewillsendyouconfirmationcode;

  /// No description provided for @enteryourmobilenumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your \nmobile number'**
  String get enteryourmobilenumber;

  /// No description provided for @weSentItToNumber.
  ///
  /// In en, this message translates to:
  /// **'We sent it to number +91'**
  String get weSentItToNumber;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @countryCode.
  ///
  /// In en, this message translates to:
  /// **'+91'**
  String get countryCode;

  /// No description provided for @enterCodeSendToYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter code \nsend to your phone'**
  String get enterCodeSendToYourPhone;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @limitReachedForOtp.
  ///
  /// In en, this message translates to:
  /// **'Limit reached for OTP resend.'**
  String get limitReachedForOtp;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in'**
  String get resendCodeIn;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @youWentOffline.
  ///
  /// In en, this message translates to:
  /// **'You went offline'**
  String get youWentOffline;

  /// No description provided for @youWentOfflineSupportText.
  ///
  /// In en, this message translates to:
  /// **'It seems you don’t have an internet connection, or your signal is too low.'**
  String get youWentOfflineSupportText;

  /// No description provided for @errorEmptyInput.
  ///
  /// In en, this message translates to:
  /// **'Field can not be empty!'**
  String get errorEmptyInput;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Title'**
  String get enterTitle;

  /// No description provided for @pleaseEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get pleaseEnterTitle;

  /// No description provided for @titleMustBeAtLeast.
  ///
  /// In en, this message translates to:
  /// **'Title must be at least 5 characters'**
  String get titleMustBeAtLeast;

  /// No description provided for @createTaskTitleNote.
  ///
  /// In en, this message translates to:
  /// **'Add short and precise title for the feature.'**
  String get createTaskTitleNote;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter Description'**
  String get enterDescription;

  /// No description provided for @pleaseEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get pleaseEnterDescription;

  /// No description provided for @descriptionMustBeAtLeast.
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 20 characters'**
  String get descriptionMustBeAtLeast;

  /// No description provided for @createTaskDescriptionNote.
  ///
  /// In en, this message translates to:
  /// **'Explain the key aspects of it with short details.'**
  String get createTaskDescriptionNote;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'kn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
