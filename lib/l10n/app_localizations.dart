import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_pt.dart';

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
    Locale('es'),
    Locale('hi'),
    Locale('kn'),
    Locale('pt'),
  ];

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

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get expert;

  /// No description provided for @regular.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get regular;

  /// No description provided for @expertPending.
  ///
  /// In en, this message translates to:
  /// **'Expert Pending'**
  String get expertPending;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @helloTitleFormat.
  ///
  /// In en, this message translates to:
  /// **'Hello, %s'**
  String get helloTitleFormat;

  /// No description provided for @howCanWeHelpYou.
  ///
  /// In en, this message translates to:
  /// **'How can we help you today?'**
  String get howCanWeHelpYou;

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

  /// No description provided for @internetNotConnected.
  ///
  /// In en, this message translates to:
  /// **'You don’t have an internet connection, or your signal is too low.'**
  String get internetNotConnected;

  /// No description provided for @titleSetupYourProafile.
  ///
  /// In en, this message translates to:
  /// **'Setup your \nprofile'**
  String get titleSetupYourProafile;

  /// No description provided for @fileUpload.
  ///
  /// In en, this message translates to:
  /// **'File upload'**
  String get fileUpload;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @quote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get quote;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @loreamIpsum.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu felis non massa tincidunt vestibulum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu felis non massa tincidunt'**
  String get loreamIpsum;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @textContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get textContinue;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @course.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get course;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @posts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// No description provided for @shorts.
  ///
  /// In en, this message translates to:
  /// **'Shorts'**
  String get shorts;

  /// No description provided for @poll.
  ///
  /// In en, this message translates to:
  /// **'Poll'**
  String get poll;

  /// No description provided for @audio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// No description provided for @youtube.
  ///
  /// In en, this message translates to:
  /// **'Youtube'**
  String get youtube;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @webLink.
  ///
  /// In en, this message translates to:
  /// **'Web Link'**
  String get webLink;

  /// No description provided for @pdf.
  ///
  /// In en, this message translates to:
  /// **'pdf'**
  String get pdf;

  /// No description provided for @addNewBook.
  ///
  /// In en, this message translates to:
  /// **'Add new book'**
  String get addNewBook;

  /// No description provided for @bookTitle.
  ///
  /// In en, this message translates to:
  /// **'Book title'**
  String get bookTitle;

  /// No description provided for @bookDescription.
  ///
  /// In en, this message translates to:
  /// **'Book description'**
  String get bookDescription;

  /// No description provided for @bookUploadCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload book photo'**
  String get bookUploadCoverTitle;

  /// No description provided for @bookUploadPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'You can upload only single pdf file'**
  String get bookUploadPdfTitle;

  /// No description provided for @addBook.
  ///
  /// In en, this message translates to:
  /// **'Add Book'**
  String get addBook;

  /// No description provided for @addNewCourse.
  ///
  /// In en, this message translates to:
  /// **'Add New Course'**
  String get addNewCourse;

  /// No description provided for @courseTitle.
  ///
  /// In en, this message translates to:
  /// **'Course title'**
  String get courseTitle;

  /// No description provided for @courseDescription.
  ///
  /// In en, this message translates to:
  /// **'Course description'**
  String get courseDescription;

  /// No description provided for @courseUploadCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload course photo'**
  String get courseUploadCoverTitle;

  /// No description provided for @addCourse.
  ///
  /// In en, this message translates to:
  /// **'Add Course'**
  String get addCourse;

  /// No description provided for @communityDetails.
  ///
  /// In en, this message translates to:
  /// **'Community details'**
  String get communityDetails;

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community title'**
  String get communityTitle;

  /// No description provided for @communityDescription.
  ///
  /// In en, this message translates to:
  /// **'Community description'**
  String get communityDescription;

  /// No description provided for @communityUploadProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Community profile photo'**
  String get communityUploadProfileTitle;

  /// No description provided for @communityUploadCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Community Cover photo'**
  String get communityUploadCoverTitle;

  /// No description provided for @createCommunity.
  ///
  /// In en, this message translates to:
  /// **'Create Community'**
  String get createCommunity;

  /// No description provided for @mediaDetails.
  ///
  /// In en, this message translates to:
  /// **'Post details'**
  String get mediaDetails;

  /// No description provided for @mediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Post title'**
  String get mediaTitle;

  /// No description provided for @mediaDescription.
  ///
  /// In en, this message translates to:
  /// **'Post description'**
  String get mediaDescription;

  /// No description provided for @mediaUploadProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Post profile photo'**
  String get mediaUploadProfileTitle;

  /// No description provided for @mediaUploadCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Images'**
  String get mediaUploadCoverTitle;

  /// No description provided for @coverUploadCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Cover photo'**
  String get coverUploadCoverTitle;

  /// No description provided for @createMedia.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createMedia;

  /// No description provided for @shortsDetails.
  ///
  /// In en, this message translates to:
  /// **'Shorts details'**
  String get shortsDetails;

  /// No description provided for @shortsUploadCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Shorts Video'**
  String get shortsUploadCoverTitle;

  /// No description provided for @createShorts.
  ///
  /// In en, this message translates to:
  /// **'Create Shorts'**
  String get createShorts;

  /// No description provided for @podcastDetails.
  ///
  /// In en, this message translates to:
  /// **'Podcast details'**
  String get podcastDetails;

  /// No description provided for @podcastTitle.
  ///
  /// In en, this message translates to:
  /// **'Podcast title'**
  String get podcastTitle;

  /// No description provided for @podcastDescription.
  ///
  /// In en, this message translates to:
  /// **'Podcast description'**
  String get podcastDescription;

  /// No description provided for @podcastLink.
  ///
  /// In en, this message translates to:
  /// **'Podcast Link'**
  String get podcastLink;

  /// No description provided for @createPodcast.
  ///
  /// In en, this message translates to:
  /// **'Create Podcast'**
  String get createPodcast;

  /// No description provided for @qaDetails.
  ///
  /// In en, this message translates to:
  /// **'Question details'**
  String get qaDetails;

  /// No description provided for @qaTitle.
  ///
  /// In en, this message translates to:
  /// **'Question title'**
  String get qaTitle;

  /// No description provided for @qaDescription.
  ///
  /// In en, this message translates to:
  /// **'Question description'**
  String get qaDescription;

  /// No description provided for @qaUploadProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get qaUploadProfileTitle;

  /// No description provided for @createQA.
  ///
  /// In en, this message translates to:
  /// **'Ask'**
  String get createQA;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @answers.
  ///
  /// In en, this message translates to:
  /// **'Answers'**
  String get answers;

  /// No description provided for @weblinkDetails.
  ///
  /// In en, this message translates to:
  /// **'Web Link details'**
  String get weblinkDetails;

  /// No description provided for @weblinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Web Link title'**
  String get weblinkTitle;

  /// No description provided for @weblinkDescription.
  ///
  /// In en, this message translates to:
  /// **'Web Link description'**
  String get weblinkDescription;

  /// No description provided for @weblink.
  ///
  /// In en, this message translates to:
  /// **'Web Link'**
  String get weblink;

  /// No description provided for @createWeblink.
  ///
  /// In en, this message translates to:
  /// **'Create Web Link'**
  String get createWeblink;

  /// No description provided for @youtubeLinkDetails.
  ///
  /// In en, this message translates to:
  /// **'Youtube Link details'**
  String get youtubeLinkDetails;

  /// No description provided for @youtubeLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Youtube Link title'**
  String get youtubeLinkTitle;

  /// No description provided for @youtubeLinkDescription.
  ///
  /// In en, this message translates to:
  /// **'Youtube Link description'**
  String get youtubeLinkDescription;

  /// No description provided for @youtubeLink.
  ///
  /// In en, this message translates to:
  /// **'Youtube Link'**
  String get youtubeLink;

  /// No description provided for @createYoutubeLink.
  ///
  /// In en, this message translates to:
  /// **'Create Youtube Link'**
  String get createYoutubeLink;

  /// No description provided for @eventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event title'**
  String get eventTitle;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event description'**
  String get eventDescription;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get endTime;

  /// No description provided for @eventUploadPhotosTitle.
  ///
  /// In en, this message translates to:
  /// **'You can upload max 5 photos'**
  String get eventUploadPhotosTitle;

  /// No description provided for @createEvent.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEvent;

  /// No description provided for @bookPhoto.
  ///
  /// In en, this message translates to:
  /// **'Book Photo'**
  String get bookPhoto;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @unJoin.
  ///
  /// In en, this message translates to:
  /// **'Un-Join'**
  String get unJoin;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @unfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get unfollow;

  /// No description provided for @interested.
  ///
  /// In en, this message translates to:
  /// **'Interested'**
  String get interested;

  /// No description provided for @notInterested.
  ///
  /// In en, this message translates to:
  /// **'Not Interested'**
  String get notInterested;

  /// No description provided for @errorFollowCommunity.
  ///
  /// In en, this message translates to:
  /// **'Follow the community to perform this action'**
  String get errorFollowCommunity;

  /// No description provided for @errorNotValidName.
  ///
  /// In en, this message translates to:
  /// **'The name you entered contains numbers or exceeds the maximum number of characters allowed. Please enter the name again.'**
  String get errorNotValidName;

  /// No description provided for @errorNotValidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address you entered is incorrect. Please enter a valid email address'**
  String get errorNotValidEmail;

  /// No description provided for @errorNotValidDob.
  ///
  /// In en, this message translates to:
  /// **'Please select Date of birth of the user'**
  String get errorNotValidDob;

  /// No description provided for @errorNotValidGender.
  ///
  /// In en, this message translates to:
  /// **'Please select Gender of the user'**
  String get errorNotValidGender;

  /// No description provided for @errorNotValidUser.
  ///
  /// In en, this message translates to:
  /// **'Please select User type'**
  String get errorNotValidUser;

  /// No description provided for @errorNotValidTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter title'**
  String get errorNotValidTitle;

  /// No description provided for @errorNotValidDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter description'**
  String get errorNotValidDescription;

  /// No description provided for @errorNotValidUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid URL'**
  String get errorNotValidUrl;

  /// No description provided for @errorLanguageInput.
  ///
  /// In en, this message translates to:
  /// **'Please enter at-least one or more language you know'**
  String get errorLanguageInput;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @blockUser.
  ///
  /// In en, this message translates to:
  /// **'Block this user'**
  String get blockUser;

  /// No description provided for @unblockUser.
  ///
  /// In en, this message translates to:
  /// **'Un-block this user'**
  String get unblockUser;

  /// No description provided for @blockedUsers.
  ///
  /// In en, this message translates to:
  /// **'Blocked Users'**
  String get blockedUsers;

  /// No description provided for @blockedUsersTitle.
  ///
  /// In en, this message translates to:
  /// **'This person is blocked by you'**
  String get blockedUsersTitle;

  /// No description provided for @blockedUsersDescription.
  ///
  /// In en, this message translates to:
  /// **'You can unblock users from here. Unblocking will allow them to see your profile and posts.'**
  String get blockedUsersDescription;

  /// No description provided for @blockedUsersAction.
  ///
  /// In en, this message translates to:
  /// **'You can manage your blocked users from here.'**
  String get blockedUsersAction;

  /// No description provided for @blockedByOtherUserTitle.
  ///
  /// In en, this message translates to:
  /// **'you have been blocked'**
  String get blockedByOtherUserTitle;

  /// No description provided for @blockedByOtherUserDescription.
  ///
  /// In en, this message translates to:
  /// **'You have been blocked by the user. You can not see their profile or posts.'**
  String get blockedByOtherUserDescription;

  /// No description provided for @noBlockedUsersTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You have not blocked any users yet.'**
  String get noBlockedUsersTitle;

  /// No description provided for @noBlockedUsersDescription.
  ///
  /// In en, this message translates to:
  /// **'You can block users from their profile or posts. Blocking will prevent them from seeing your profile and posts.'**
  String get noBlockedUsersDescription;

  /// No description provided for @noFollowersTitle.
  ///
  /// In en, this message translates to:
  /// **'You have no followers yet.'**
  String get noFollowersTitle;

  /// No description provided for @noFollowersDescription.
  ///
  /// In en, this message translates to:
  /// **'You can gain followers by sharing your profile with others or by posting content that others find interesting.'**
  String get noFollowersDescription;

  /// No description provided for @noFollowingTitle.
  ///
  /// In en, this message translates to:
  /// **'You are not following anyone yet.'**
  String get noFollowingTitle;

  /// No description provided for @noFollowingDescription.
  ///
  /// In en, this message translates to:
  /// **'You can follow users by visiting their profile and clicking on the follow button.'**
  String get noFollowingDescription;

  /// No description provided for @noShoutOutsTitle.
  ///
  /// In en, this message translates to:
  /// **'You have not created any shout outs yet.'**
  String get noShoutOutsTitle;

  /// No description provided for @noShoutOutsDescription.
  ///
  /// In en, this message translates to:
  /// **'You can create shout outs to connect with your community. Shout outs are a great way to greet others and increase your reach in the community.'**
  String get noShoutOutsDescription;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @reportUser.
  ///
  /// In en, this message translates to:
  /// **'Report this user'**
  String get reportUser;

  /// No description provided for @reportComment.
  ///
  /// In en, this message translates to:
  /// **'Report this comment'**
  String get reportComment;

  /// No description provided for @errorEmptyInput.
  ///
  /// In en, this message translates to:
  /// **'Field can not be empty!'**
  String get errorEmptyInput;

  /// No description provided for @errorFees.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid fees in numeric format'**
  String get errorFees;

  /// No description provided for @errorExperience.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid experience in numeric format (Range 0-70)'**
  String get errorExperience;

  /// No description provided for @errorSelectCost.
  ///
  /// In en, this message translates to:
  /// **'Please select cost'**
  String get errorSelectCost;

  /// No description provided for @errorPleaseUploadAtLeastOneFile.
  ///
  /// In en, this message translates to:
  /// **'Please upload at least one file'**
  String get errorPleaseUploadAtLeastOneFile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get changeTheme;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @followersFollowings.
  ///
  /// In en, this message translates to:
  /// **'Followers & followings'**
  String get followersFollowings;

  /// No description provided for @switchToExpert.
  ///
  /// In en, this message translates to:
  /// **'Switch profile to expert'**
  String get switchToExpert;

  /// No description provided for @cancelUpgradeToExpert.
  ///
  /// In en, this message translates to:
  /// **'Cancel upgrade profile to expert'**
  String get cancelUpgradeToExpert;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @sharePost.
  ///
  /// In en, this message translates to:
  /// **'Share post with others'**
  String get sharePost;

  /// No description provided for @shareProfile.
  ///
  /// In en, this message translates to:
  /// **'Share profile with others'**
  String get shareProfile;

  /// No description provided for @reportPost.
  ///
  /// In en, this message translates to:
  /// **'Report this post'**
  String get reportPost;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'url'**
  String get url;

  /// No description provided for @addUrl.
  ///
  /// In en, this message translates to:
  /// **'Add url'**
  String get addUrl;

  /// No description provided for @deletePost.
  ///
  /// In en, this message translates to:
  /// **'Delete this post'**
  String get deletePost;

  /// No description provided for @doYouWantToDeletePost.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this post?'**
  String get doYouWantToDeletePost;

  /// No description provided for @deleteCommunity.
  ///
  /// In en, this message translates to:
  /// **'Delete this Community'**
  String get deleteCommunity;

  /// No description provided for @doYouWantToDeleteCommunity.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this Community?'**
  String get doYouWantToDeleteCommunity;

  /// No description provided for @deleteComment.
  ///
  /// In en, this message translates to:
  /// **'Delete this Comment'**
  String get deleteComment;

  /// No description provided for @doYouWantToDeleteComment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this comment?'**
  String get doYouWantToDeleteComment;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @subCategory.
  ///
  /// In en, this message translates to:
  /// **'Sub category'**
  String get subCategory;

  /// No description provided for @fees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get fees;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @qualification.
  ///
  /// In en, this message translates to:
  /// **'Qualification'**
  String get qualification;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'tags'**
  String get tags;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @briefDetail.
  ///
  /// In en, this message translates to:
  /// **'Brief detail'**
  String get briefDetail;

  /// No description provided for @betterDefineYou.
  ///
  /// In en, this message translates to:
  /// **'Better define you'**
  String get betterDefineYou;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @readTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Read terms and conditions'**
  String get readTermsAndConditions;

  /// No description provided for @iHaveReadTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'I have read terms & conditions'**
  String get iHaveReadTermsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @readPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Read privacy policy'**
  String get readPrivacyPolicy;

  /// No description provided for @iHaveReadPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'I have read privacy policy'**
  String get iHaveReadPrivacyPolicy;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About in-STA'**
  String get aboutApp;

  /// No description provided for @manifesto.
  ///
  /// In en, this message translates to:
  /// **'Manifesto'**
  String get manifesto;

  /// No description provided for @lessonDetails.
  ///
  /// In en, this message translates to:
  /// **'Lesson details'**
  String get lessonDetails;

  /// No description provided for @lessonName.
  ///
  /// In en, this message translates to:
  /// **'Lesson name'**
  String get lessonName;

  /// No description provided for @lessonDescription.
  ///
  /// In en, this message translates to:
  /// **'Lesson description'**
  String get lessonDescription;

  /// No description provided for @lessonVideoURL.
  ///
  /// In en, this message translates to:
  /// **'Lesson video URL'**
  String get lessonVideoURL;

  /// No description provided for @addLesson.
  ///
  /// In en, this message translates to:
  /// **'Add lesson'**
  String get addLesson;

  /// No description provided for @followersFollowingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Followers / Followings'**
  String get followersFollowingsTitle;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @followings.
  ///
  /// In en, this message translates to:
  /// **'Followings'**
  String get followings;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @errorFeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s connect with the world'**
  String get errorFeedTitle;

  /// No description provided for @errorFeedDescription.
  ///
  /// In en, this message translates to:
  /// **'Search and Share your thoughts, ideas, and experiences with the world'**
  String get errorFeedDescription;

  /// No description provided for @noFeedFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No updates at the moment'**
  String get noFeedFoundTitle;

  /// No description provided for @noFeedFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any content at the moment.\nPlease check back later or try refreshing the page'**
  String get noFeedFoundDescription;

  /// No description provided for @feedReported.
  ///
  /// In en, this message translates to:
  /// **'You are not seeing this post because post has been reported'**
  String get feedReported;

  /// No description provided for @feedDeleted.
  ///
  /// In en, this message translates to:
  /// **'You are not seeing this post because post has been deleted'**
  String get feedDeleted;

  /// No description provided for @userReported.
  ///
  /// In en, this message translates to:
  /// **'You are not seeing this post because User has been reported'**
  String get userReported;

  /// No description provided for @commentReported.
  ///
  /// In en, this message translates to:
  /// **'You are not seeing comment has been reported'**
  String get commentReported;

  /// No description provided for @reasonText.
  ///
  /// In en, this message translates to:
  /// **'Reason: %s'**
  String get reasonText;

  /// No description provided for @emojiListTitle.
  ///
  /// In en, this message translates to:
  /// **'Emojis / Reactions'**
  String get emojiListTitle;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likes;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @calls.
  ///
  /// In en, this message translates to:
  /// **'Calls'**
  String get calls;

  /// No description provided for @appointmentsTime.
  ///
  /// In en, this message translates to:
  /// **'Appointments Time'**
  String get appointmentsTime;

  /// No description provided for @myDashboard.
  ///
  /// In en, this message translates to:
  /// **'My Dashboard'**
  String get myDashboard;

  /// No description provided for @tagged.
  ///
  /// In en, this message translates to:
  /// **'Tagged'**
  String get tagged;

  /// No description provided for @tabForYou.
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get tabForYou;

  /// No description provided for @tabFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get tabFriends;

  /// No description provided for @tabTrending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get tabTrending;

  /// No description provided for @tabCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get tabCommunity;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @makeProfilePublic.
  ///
  /// In en, this message translates to:
  /// **'Show on profile publicly'**
  String get makeProfilePublic;

  /// No description provided for @personDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personDetails;

  /// No description provided for @aboutYou.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get aboutYou;

  /// No description provided for @contactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact details'**
  String get contactDetails;

  /// No description provided for @links.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get links;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @moreInfo.
  ///
  /// In en, this message translates to:
  /// **'More Info'**
  String get moreInfo;

  /// No description provided for @moreProfiles.
  ///
  /// In en, this message translates to:
  /// **'More Profiles'**
  String get moreProfiles;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @profileTags.
  ///
  /// In en, this message translates to:
  /// **'Profile tags'**
  String get profileTags;

  /// No description provided for @noDataToShow.
  ///
  /// In en, this message translates to:
  /// **'No data to show'**
  String get noDataToShow;

  /// No description provided for @profileDataPublic.
  ///
  /// In en, this message translates to:
  /// **'Your Profile data is public, you can disable it from settings'**
  String get profileDataPublic;

  /// No description provided for @profileDataPrivate.
  ///
  /// In en, this message translates to:
  /// **'Your Profile data is private, you can enable it from settings'**
  String get profileDataPrivate;

  /// No description provided for @announcement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  /// No description provided for @qa.
  ///
  /// In en, this message translates to:
  /// **'Q&A'**
  String get qa;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @pinnedUrl.
  ///
  /// In en, this message translates to:
  /// **'Pinned URL'**
  String get pinnedUrl;

  /// No description provided for @pinnedUrlDescription.
  ///
  /// In en, this message translates to:
  /// **'Pin a website, video, or article link to your post so more people notice, click, and interact.'**
  String get pinnedUrlDescription;

  /// No description provided for @feedCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'post created successfully'**
  String get feedCreatedSuccessfully;

  /// No description provided for @liveChannels.
  ///
  /// In en, this message translates to:
  /// **'Live Channels'**
  String get liveChannels;

  /// No description provided for @liveChannelsAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin - Live Channels'**
  String get liveChannelsAdmin;

  /// No description provided for @deleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile'**
  String get deleteProfile;

  /// No description provided for @deleteProfileTextOne.
  ///
  /// In en, this message translates to:
  /// **'We understand that sometimes you might need to take a break. But before you go, we want to let you know how much we value you as a member of our community.\n\nYour contributions, insights, and presence make a real difference. We truly appreciate having you here.\n\nIf you\'re sure you want to proceed, you can delete your profile by clicking the following link:'**
  String get deleteProfileTextOne;

  /// No description provided for @deleteProfileTextTwo.
  ///
  /// In en, this message translates to:
  /// **'This will redirect you to a web page where you can complete the process.\n\nPlease know that we\'re always working to improve your experience, and we hope you\'ll consider staying with us. If you have any feedback or concerns, we\'d love to hear from you.'**
  String get deleteProfileTextTwo;

  /// No description provided for @deleteCommunityTextOne.
  ///
  /// In en, this message translates to:
  /// **'We understand that sometimes you might need to take a break. But before you go, we want to let you know how much we value you as a member of our community.\n\nYour contributions, insights, and presence make a real difference. We truly appreciate having you here.\n\nIf you\'re sure you want to proceed, you can delete your community by clicking the following link:'**
  String get deleteCommunityTextOne;

  /// No description provided for @deleteCommunityTextTwo.
  ///
  /// In en, this message translates to:
  /// **'This will tell our server about your decision to delete.\n\nPlease know that we\'re always working to improve your experience, and we hope you\'ll consider staying with us inside application and contributing in communities. If you have any feedback or concerns, we\'d love to hear from you.'**
  String get deleteCommunityTextTwo;

  /// No description provided for @shareProfileText.
  ///
  /// In en, this message translates to:
  /// **'Excited to be part of this community! Follow %s for updates on %s'**
  String get shareProfileText;

  /// No description provided for @sharePostText.
  ///
  /// In en, this message translates to:
  /// **'Check out this post by %s on in-STA.'**
  String get sharePostText;

  /// No description provided for @shareCommunityText.
  ///
  /// In en, this message translates to:
  /// **'Join the community on in-STA\n\n%s'**
  String get shareCommunityText;

  /// No description provided for @handle.
  ///
  /// In en, this message translates to:
  /// **'Handle'**
  String get handle;

  /// No description provided for @updateUserHandle.
  ///
  /// In en, this message translates to:
  /// **'Update User Handle'**
  String get updateUserHandle;

  /// No description provided for @updateUserHandleText.
  ///
  /// In en, this message translates to:
  /// **'Your user handle is a unique identifier that helps other users find you on in-STA. You can change your handle at any time, people trust you and know you by this handle.'**
  String get updateUserHandleText;

  /// No description provided for @currentUserHandleLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Handle:'**
  String get currentUserHandleLabel;

  /// No description provided for @availableHandles.
  ///
  /// In en, this message translates to:
  /// **'Available Handles'**
  String get availableHandles;

  /// No description provided for @userHandleEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a handle'**
  String get userHandleEmptyError;

  /// No description provided for @userHandleSameError.
  ///
  /// In en, this message translates to:
  /// **'Please select a different handle'**
  String get userHandleSameError;

  /// No description provided for @errorPrivacyPolicyRead.
  ///
  /// In en, this message translates to:
  /// **'Please read privacy policy'**
  String get errorPrivacyPolicyRead;

  /// No description provided for @errorTermsAndConditionRead.
  ///
  /// In en, this message translates to:
  /// **'Please read terms and conditions'**
  String get errorTermsAndConditionRead;

  /// No description provided for @sampleCard.
  ///
  /// In en, this message translates to:
  /// **'Sample Card'**
  String get sampleCard;

  /// No description provided for @going.
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get going;

  /// No description provided for @notGoing.
  ///
  /// In en, this message translates to:
  /// **'Not Going'**
  String get notGoing;

  /// No description provided for @uncertain.
  ///
  /// In en, this message translates to:
  /// **'Uncertain'**
  String get uncertain;

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
  /// **'in-STA'**
  String get onboardingTitle2Screen1;

  /// No description provided for @onboardingSubTitle1Screen1.
  ///
  /// In en, this message translates to:
  /// **'Swadeshi platform built for the world. Connect with like-minded people, exchange perspectives, and celebrate identity together.'**
  String get onboardingSubTitle1Screen1;

  /// No description provided for @onboardingTitle1Screen2.
  ///
  /// In en, this message translates to:
  /// **'Join the'**
  String get onboardingTitle1Screen2;

  /// No description provided for @onboardingTitle2Screen2.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get onboardingTitle2Screen2;

  /// No description provided for @onboardingSubTitle1Screen2.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts, ideas, and stories. From culture to creativity, discover a safe space where your voice finds connection and respect.'**
  String get onboardingSubTitle1Screen2;

  /// No description provided for @onboardingTitle1Screen5.
  ///
  /// In en, this message translates to:
  /// **'Celebrate'**
  String get onboardingTitle1Screen5;

  /// No description provided for @onboardingTitle2Screen5.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
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
  /// **'Engage'**
  String get onboardingTitle1Screen3;

  /// No description provided for @onboardingTitle2Screen3.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get onboardingTitle2Screen3;

  /// No description provided for @onboardingSubTitle1Screen3.
  ///
  /// In en, this message translates to:
  /// **'Post, like, and engage with people who understand you. Build bonds, learn new things, and feel at home in a community made for you.'**
  String get onboardingSubTitle1Screen3;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @centeredScrollableTabs.
  ///
  /// In en, this message translates to:
  /// **'Centered Scrollable Tabs'**
  String get centeredScrollableTabs;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// No description provided for @dislike.
  ///
  /// In en, this message translates to:
  /// **'Dislike'**
  String get dislike;

  /// No description provided for @emoji.
  ///
  /// In en, this message translates to:
  /// **'Emoji'**
  String get emoji;

  /// No description provided for @switchCommunity.
  ///
  /// In en, this message translates to:
  /// **'Switch Community'**
  String get switchCommunity;

  /// No description provided for @reportCommunity.
  ///
  /// In en, this message translates to:
  /// **'Report community'**
  String get reportCommunity;

  /// No description provided for @switchCommunityDescription.
  ///
  /// In en, this message translates to:
  /// **'You can switch to another community. This will help you to connect with your friends and family.'**
  String get switchCommunityDescription;

  /// No description provided for @shareCommunityWithOthers.
  ///
  /// In en, this message translates to:
  /// **'Share Community With Others'**
  String get shareCommunityWithOthers;

  /// No description provided for @onlyAdminCanPost.
  ///
  /// In en, this message translates to:
  /// **'Only Admin Can Post'**
  String get onlyAdminCanPost;

  /// No description provided for @myPosts.
  ///
  /// In en, this message translates to:
  /// **'My Posts'**
  String get myPosts;

  /// No description provided for @pinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get pinned;

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

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @writeComment.
  ///
  /// In en, this message translates to:
  /// **'Write a comment'**
  String get writeComment;

  /// No description provided for @giveTheAnswer.
  ///
  /// In en, this message translates to:
  /// **'Give the answer'**
  String get giveTheAnswer;

  /// No description provided for @socialHandler.
  ///
  /// In en, this message translates to:
  /// **'Social handler'**
  String get socialHandler;

  /// No description provided for @selectSocialHandler.
  ///
  /// In en, this message translates to:
  /// **'Select Social Handler'**
  String get selectSocialHandler;

  /// No description provided for @linksWillBeVisibleOnProfile.
  ///
  /// In en, this message translates to:
  /// **'Links will be visible on your profile'**
  String get linksWillBeVisibleOnProfile;

  /// No description provided for @profileImageAndHandleEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Image or Handle'**
  String get profileImageAndHandleEditTitle;

  /// No description provided for @profileImageAndHandleEditDescription.
  ///
  /// In en, this message translates to:
  /// **'You can change your profile image or handle at any time. People trust you and know you by this image and handle.'**
  String get profileImageAndHandleEditDescription;

  /// No description provided for @updateProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Update Profile Image'**
  String get updateProfileImage;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @topComment.
  ///
  /// In en, this message translates to:
  /// **'Top Comment'**
  String get topComment;

  /// No description provided for @allowAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow Access'**
  String get allowAccess;

  /// No description provided for @contactPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Contact Permission Required'**
  String get contactPermissionRequired;

  /// No description provided for @contactPermissionRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'I agree to share my Contact List with in-STA so that I can connect with friends and invite others to join.'**
  String get contactPermissionRequiredDescription;

  /// No description provided for @contactPermissionCheckMoreText.
  ///
  /// In en, this message translates to:
  /// **'Check more, why it is important'**
  String get contactPermissionCheckMoreText;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get permissionDenied;

  /// No description provided for @permissionDeniedDescription.
  ///
  /// In en, this message translates to:
  /// **'You have denied the permission to access this feature. Please go to settings and enable the permission.'**
  String get permissionDeniedDescription;

  /// No description provided for @appMaintenance.
  ///
  /// In en, this message translates to:
  /// **'App Maintenance'**
  String get appMaintenance;

  /// No description provided for @appMaintenanceDescription.
  ///
  /// In en, this message translates to:
  /// **'We are currently doing some maintenance work on the app. Please check back later.'**
  String get appMaintenanceDescription;

  /// No description provided for @availableContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Available Contacts on in-STA'**
  String get availableContactsTitle;

  /// No description provided for @availableContactsDescription.
  ///
  /// In en, this message translates to:
  /// **'We found some of your contacts on in-STA. You can connect with them by sending them a request.'**
  String get availableContactsDescription;

  /// No description provided for @inviteContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite to in-STA'**
  String get inviteContactsTitle;

  /// No description provided for @inviteContactsDescription.
  ///
  /// In en, this message translates to:
  /// **'We found some of your contacts not on in-STA. You can invite them to join in-STA by sending them an invite.'**
  String get inviteContactsDescription;

  /// No description provided for @alreadyInvited.
  ///
  /// In en, this message translates to:
  /// **'Already Invited'**
  String get alreadyInvited;

  /// No description provided for @alreadyJoined.
  ///
  /// In en, this message translates to:
  /// **'Already Joined'**
  String get alreadyJoined;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @member.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get member;

  /// No description provided for @makeAdmin.
  ///
  /// In en, this message translates to:
  /// **'Make Admin'**
  String get makeAdmin;

  /// No description provided for @removeAdmin.
  ///
  /// In en, this message translates to:
  /// **'Remove Admin'**
  String get removeAdmin;

  /// No description provided for @removeMember.
  ///
  /// In en, this message translates to:
  /// **'Remove Member'**
  String get removeMember;

  /// No description provided for @removeInvite.
  ///
  /// In en, this message translates to:
  /// **'Remove Invite'**
  String get removeInvite;

  /// No description provided for @userSuggestion.
  ///
  /// In en, this message translates to:
  /// **'User suggestion'**
  String get userSuggestion;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @shoutOut.
  ///
  /// In en, this message translates to:
  /// **'Shout out'**
  String get shoutOut;

  /// No description provided for @shoutOutDescription.
  ///
  /// In en, this message translates to:
  /// **'Set a daily shoutout for your community – a fun slogan or message that your members can say once a day to stay connected.'**
  String get shoutOutDescription;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloading;

  /// No description provided for @downloadMediaDescription.
  ///
  /// In en, this message translates to:
  /// **'You can download the media from here. Media will be downloaded to your device.'**
  String get downloadMediaDescription;

  /// No description provided for @downloadStartedWait.
  ///
  /// In en, this message translates to:
  /// **'Download started, Media is getting downloaded. Please wait.'**
  String get downloadStartedWait;

  /// No description provided for @multipleMediaToDownloadText.
  ///
  /// In en, this message translates to:
  /// **'You have selected multiple media to download. Do you want to download all the media?'**
  String get multipleMediaToDownloadText;

  /// No description provided for @downloadAll.
  ///
  /// In en, this message translates to:
  /// **'Download all'**
  String get downloadAll;

  /// No description provided for @multipleMediaMetaData.
  ///
  /// In en, this message translates to:
  /// **'Images: %s\t|\tVideos: %s'**
  String get multipleMediaMetaData;

  /// No description provided for @setAsWallpaper.
  ///
  /// In en, this message translates to:
  /// **'Set as wallpaper'**
  String get setAsWallpaper;

  /// No description provided for @underDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Under development'**
  String get underDevelopment;

  /// No description provided for @underDevelopmentDescription.
  ///
  /// In en, this message translates to:
  /// **'This feature is under development. Please check back later.'**
  String get underDevelopmentDescription;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @shoutOutWishInCommunity.
  ///
  /// In en, this message translates to:
  /// **'Wish %s daily and increase your reach in the community'**
  String get shoutOutWishInCommunity;

  /// No description provided for @shoutOutDays.
  ///
  /// In en, this message translates to:
  /// **'%s Days'**
  String get shoutOutDays;

  /// No description provided for @shoutOutSayTodayTitleText.
  ///
  /// In en, this message translates to:
  /// **'Say today\'s %s'**
  String get shoutOutSayTodayTitleText;

  /// No description provided for @shoutOutSayTodayButtonText.
  ///
  /// In en, this message translates to:
  /// **'Say %s'**
  String get shoutOutSayTodayButtonText;

  /// No description provided for @shoutOutWishedInCommunityTitleText.
  ///
  /// In en, this message translates to:
  /// **'You have wished %s for today'**
  String get shoutOutWishedInCommunityTitleText;

  /// No description provided for @shoutOutWishedInCommunityDescriptionText.
  ///
  /// In en, this message translates to:
  /// **'You have wished today\'s %s to %s people. You can wish again tomorrow.'**
  String get shoutOutWishedInCommunityDescriptionText;

  /// No description provided for @shoutOutWishedInCommunityListDescriptionText.
  ///
  /// In en, this message translates to:
  /// **'%s members wished %s to you'**
  String get shoutOutWishedInCommunityListDescriptionText;

  /// No description provided for @shoutOutWishedBackByMemberTitleText.
  ///
  /// In en, this message translates to:
  /// **'You have wished back by members'**
  String get shoutOutWishedBackByMemberTitleText;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get inviteFriends;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @crop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get crop;

  /// No description provided for @tune.
  ///
  /// In en, this message translates to:
  /// **'Tune'**
  String get tune;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @selectedImaged.
  ///
  /// In en, this message translates to:
  /// **'Selected Images'**
  String get selectedImaged;
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
      <String>['en', 'es', 'hi', 'kn', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
