import 'dart:math';

import 'package:flutter/material.dart';

import '../utilities/extension_utils.dart';

class AppColor {
  AppColor._();

  static AppColor? _instance;

  static final AppColor instance = _instance ??= AppColor._();

  final shimmerColorBaseLight = Colors.grey.shade300;
  final shimmerColorHighlightLight = Colors.grey.shade100;

  final shimmerColorBaseDark = Colors.grey.shade900;
  final shimmerColorHighlightDark = Colors.grey.shade700;

  static const Color grayChateau = Color(0xFF9FA8B3);
  static const Color green = Color(0xFF17BF65);
  static const Color errorRed = Color(0xFFB82020);

  static const Color grayDisableLight = Color(0xFFC4D0DD);
  static const Color grayDisableDark = Color(0xFF455D73);
  static const Color cardItemBorder = Color(0xFFC4D0DD);
  static const Color cardDropShadow = Color(0xFFF8F8F9);
  static const Color grayChateauLight = Color(0xFF9FA8B3);
  static const Color grayChateauDark = Color(0xFF899CB3);
  static const Color steelGrey = Color(0xFF211E2B);
  static const Color lightGrey = Color(0xFFF1F5FA);
  static const Color hintColor = Color(0xFFB0A7B5);

  static const Color scaffoldBackground = Color(0xFFf1f2f2);
  static const Color greyColor = Color(0xFF707070);

  static Color white = Colors.white;
  static Color white10 = white.withValues(alpha: 0.1);
  static Color white20 = white.withValues(alpha: 0.2);
  static Color white30 = white.withValues(alpha: 0.3);
  static Color white40 = white.withValues(alpha: 0.4);
  static Color white50 = white.withValues(alpha: 0.5);
  static Color white60 = white.withValues(alpha: 0.6);
  static Color white70 = white.withValues(alpha: 0.7);
  static Color white80 = white.withValues(alpha: 0.8);
  static Color white90 = white.withValues(alpha: 0.9);

  static Color black = Colors.black;
  static Color black10 = black.withValues(alpha: 0.1);
  static Color black20 = black.withValues(alpha: 0.2);
  static Color black30 = black.withValues(alpha: 0.3);
  static Color black40 = black.withValues(alpha: 0.4);
  static Color black50 = black.withValues(alpha: 0.5);
  static Color black60 = black.withValues(alpha: 0.6);
  static Color black70 = black.withValues(alpha: 0.7);
  static Color black80 = black.withValues(alpha: 0.8);
  static Color black90 = black.withValues(alpha: 0.9);

  // Light Theme Colors
  static const Color primaryLight = themeColorPrimaryLight;
  static const Color backgroundLight = themeColorWhite;
  static const Color cardBackgroundLight = themeColorWhite;
  static const Color textHeadingLightTheme = Color(0xFF1E1E19);
  static const Color textSubHeadingLightTheme = Color(0xFF1E1E19);
  static const Color textTitleLightTheme = themeColorBlack;
  static const Color textSubTitleLightTheme = Color(0xFFc4c8cf);
  static Color textFieldColorLight = themeColorBlack.withValues(alpha: 0.05);
  static Color textFieldBorderColorLight = themeColorBlack.withValues(alpha: 0.40);
  static const Color popupBackgroundLight = themeColorWhite;
  static const Color selectionTileColorLight = themeColorWhite;
  static const Color dialogBackgroundLight = themeColorWhite;

  // Dark Theme Colors
  static const Color primaryDark = themeColorPrimaryDark;
  static const Color backgroundDark = themeColorBlack;
  static const Color cardBackgroundDark = Color(0xFF141416);
  static const Color textHeadingDarkTheme = themeColorWhite;
  static const Color textSubHeadingDarkTheme = themeColorWhite;
  static const Color textTitleDarkTheme = themeColorWhite;
  static const Color textSubTitleDarkTheme = themeColorWhite;
  static Color textFieldColorDark = themeColorWhite.withValues(alpha: 0.05);
  static Color textFieldBorderColorDark = themeColorWhite.withValues(alpha: 0.40);
  static const Color popupBackgroundDark = steelGrey;
  static const Color selectionTileColorDark = Color(0xFF292732);
  static const Color dialogBackgroundDark = Color(0xFF242748);

  static const Color appBarColor = themeColorWhite;
  static const Color textTitle = Color(0xFF323B59);
  static const Color cardCvvGrey = Color(0xFFFFF5DD);

  static const Color eventColorGreen = Color(0xFF5CD293);
  static const Color eventColorRed = Color(0xFFF04A79);

  //static const Color themeColorBlue = Color(0xFF2979FF);
  static const Color _themeColorPrimary = Color(0xFF2979FF);
  //static const Color _themeColorPrimaryChandan = Color(0xFFF6C945);
  static const Color themeColorPrimaryLight = _themeColorPrimary;
  static const Color themeColorPrimaryDark = _themeColorPrimary;
  static const Color themeColorPrimaryCommon = _themeColorPrimary;
  static const Color themeColorWhite = Color(0xFFFBFBFB);
  static const Color themeColorBlack = Color(0xFF0F0F0F);

  static const Color themeColorWebLinkDarkMode = Color(0xFF00BFFF);
  static const Color themeColorWebLinkLightMode = Color(0xFF0073FF);
  static const Color themeColorBlue = Color(0xFF2146C7);
  static const Color themeColorSkin = Color(0xFFE6CBA8);
  static const Color themeColorRed = Color(0xFFED1D58);
  static const Color themeColorRedLight = Color(0xFFE57373);
  static const Color themeColorGreen = Color(0xFF0B6E4F);
  static const Color themeColorIcon = Color(0xFF9AA1B4);
  static const Color themeColorSaffronSecondary = _themeColorPrimary;
  static Color themeColorGrey = themeColorIcon.withValues(alpha: 0.25);
  static Color themeColorGreyLight = themeColorIcon.withValues(alpha: 0.5);
  static Color themeColorGreyRipple = themeColorGrey;
  static const Color themeColorGolden = Color(0xFFD4A237);

  static const Color themeColorContainerDecorationLight = Color(0xFFF2F2F2);
  static const Color themeColorContainerDecorationDark = Color(0xFF2A2A2A);

  static const Color themeColorBlueRipple = Color(0xFF0073FF);

  static const Color purpleColor = Color(0xFFBA68C8);
  static const Color darkBlackColor = Color(0xFF000000);
  static const Color lightBlueColor = Color(0xFFA7A7F8);
  static Color themeLightGrey = themeColorIcon;
  static const Color iconGreyColor = Color(0xFF909090);
  static const Color lightGreyTextColor = Color(0xFF667080);
  static Color lightBrownColor = themeColorSkin.withValues(alpha: 0.1);

  static const Color lightYellowColor = Color(0xFFf8f4f4);
  static const Color babyPinkColor = Color(0xFFffe4ec);
  static const Color pink = Color(0xFFF86883);
  static Color lightPink = pink.withValues(alpha: 0.1);

  static const Color _bottomChipColor1 = themeColorBlue;
  static const Color _bottomChipColor3 = themeColorRed;
  static const Color _bottomChipColor2 = themeColorGreen;
  static const Color _bottomChipColor4 = themeColorPrimaryCommon;
  static const Color _bottomChipColor5 = pink;

  final List<Color> bottomChipColors = [
    _bottomChipColor1,
    _bottomChipColor2,
    _bottomChipColor3,
    _bottomChipColor4,
    _bottomChipColor5,
  ];

  final List<Color> backgroundLightColors = [
    const Color(0xFFA2D5F2), // Pastel Blue
    const Color(0xFF81C784), // Pastel Green
    const Color(0xFFFFF59D), // Pastel Yellow
    const Color(0xFFF48FB1), // Pastel Pink
    const Color(0xFFCE93D8), // Pastel Purple
    const Color(0xFFFFAB91), // Pastel Orange
    const Color(0xFFE0E0E0), // Light Grey
  ];

  final List<Color> backgroundVibrantColors = [
    const Color(0xFF3B5998), // Facebook Blue
    const Color(0xFF1DA1F2), // Twitter Blue
    const Color(0xFF405DE6), // Instagram Gradient Purple
    const Color(0xFF0077B5), // LinkedIn Blue
    const Color(0xFF4A154B), // Slack Purple
    const Color(0xFF7289DA), // Discord Blurple
    const Color(0xFF607D8B),
    const Color(0xFF455A64),
    const Color(0xFF388E3C),
    const Color(0xFF0097A7),
  ];

  Color get randomBackgroundLightColors => backgroundLightColors[Random().nextRandomNumberRangeInt(min: 0, max: backgroundLightColors.length - 1)];

  Color get randomBackgroundVibrantColors =>
      backgroundVibrantColors[Random().nextRandomNumberRangeInt(min: 0, max: backgroundVibrantColors.length - 1)];

  Color getBackgroundColor(int index, {bool isVibrantColor = false}) => isVibrantColor ? _getVibrantColorByIndex(index) : _getDullColorByIndex(index);

  Color _getDullColorByIndex(int index) => _getColorByIndex(index: index, colors: backgroundLightColors);

  Color _getVibrantColorByIndex(int index) => _getColorByIndex(index: index, colors: backgroundVibrantColors).withValues(alpha: 0.5);

  Color getBottomChipColor(int index) => _getColorByIndex(index: index, colors: bottomChipColors);

  Color _getColorByIndex({required int index, required List<Color> colors}) {
    if (index < 0) {
      index = 0;
    }

    final colorLength = colors.length;

    if (index >= colorLength) {
      index = index % colorLength;
    }

    return colors[index];
  }


  static Color? hexToColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return null;
    }

    hexColor = hexColor.replaceFirst('#', '0xff');
    return Color(int.parse(hexColor));
  }


}
