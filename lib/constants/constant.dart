import 'package:flutter/foundation.dart';

class Constant {
  Constant._();

  static Constant? _instance;

  static final Constant instance = _instance ??= Constant._();

  final urlHindu = 'https://m-insta.com/';
  final urlPrivacyPolicy = 'https://m-insta.com/privacy-policy/';
  final urlTermsOfService = 'https://m-insta.com/terms-conditions/';
  final urlManifesto = 'https://m-insta.com/manifesto/';
  final urlDeleteProfile = 'https://m-insta.com/delete-account/';
  final urlContactDisclosure = 'https://www.m-insta.com/contact-access-disclosure';

  String get remoteConfigActiveKey => kDebugMode ? 'remoteConfigDebug_insta' : 'remoteConfigs_insta';

  final shareCanonicalPathFeed = 'detail/feed/';
  final shareCanonicalPathCommunity = 'detail/community/';
  final shareCanonicalPathUser = 'detail/profile/';

  static const double cardElevation = 0.4;
  static const double cardItemBorderSize = 0.5;

  static const int nameLength = 64;
  static const int maxNameLength = 32;
  static const int maxEmailLength = 64;

  static const int int32MaxValue = 2147483647;
  static const int defaultNoOfDaysForShoutOutRecord = 5;

/*
  static final RegExp nameValidationRegex = RegExp(
    r"^([\p{L}\p{M}0-9])$|^([\p{L}\p{M}0-9]|-|\.|'|_)+(([^\S\r\n])*([\p{L}\p{M}0-9])+)+$",
    unicode: true,
  );*/

  double screenWidth = 0;
  double feedCardDefaultHeight = 240;
  double feedCardTwoMaxHeight = 300;
  double feedCardMultipleMaxHeight = 420;
  double feedCardVideoMaxHeight = 520;

  /// [RegExp] for detecting [url].
  final urlRegExp = RegExp(
    r'(http(s)?:\/\/)?(www.)?[a-zA-Z0-9]{2,256}\.[a-zA-Z0-9]{2,256}(\.[a-zA-Z0-9]{2,256})?([-a-zA-Z0-9@:%_\+~#?&//=.]*)([-a-zA-Z0-9@:%_\+~#?&//=]+)',
    caseSensitive: false,
    dotAll: true,
  );

  /// [RegExp] for detecting [email].
  final emailRegExp = RegExp(
    r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}',
    caseSensitive: false,
    dotAll: true,
  );

  /// [RegExp] for detecting [phoneNumber].
  /// checks for phone number
  /// 1. (123) 456-7890
  /// 2. (123)456-7890
  /// 3. 123-456-7890
  /// 4. 123.456.7890
  /// 5. 1234567890
  /// 6. +31636363634
  /// 7. 075-63546725
  final phoneNumberRegExp = RegExp(
    r'(\+?\d{1,4}[\s-]?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}',
    caseSensitive: false,
    dotAll: true,
  );

  /// [RegExp] for detecting [hashtag].
  final hashtagRegExp = RegExp(
    r'#[a-zA-Z0-9_]+',
    caseSensitive: false,
    dotAll: true,
  );

  /// [RegExp] for detecting [mention].
  final mentionRegExp = RegExp(
    r'(^|[^\w])@([\w\_\.]+)',
    caseSensitive: false,
    dotAll: true,
  );

}
