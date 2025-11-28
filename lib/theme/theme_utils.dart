import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_color.dart';

class ThemeUtils {
  static final ThemeUtils instance = ThemeUtils();

  late ThemeMode _themeMode;

  final letterSpacing = 1.0;
  // Parent Theme Data Related Properties
  Brightness? brightness;
  Color? scaffoldBackgroundColor;
  Color? backgroundColor;
  Color? cardColor;
  Color? dialogBackgroundColor;
  Color? textHeadingColor;
  Color? textSubHeadingColor;
  Color? textColorTitle;
  Color? textColorSubTitle;
  Color? textFieldColor;
  Color? textFieldBorderColor;

  // Child Color Theme Data Related Properties
  Color primaryColor = AppColor.primaryLight;
  Color? shadowColor;
  Color? bottomAppBarColor;
  Color? focusColor;
  Color? hoverColor;
  Color? highlightColor;
  Color? splashColor;
  Color? disabledColor;
  Color? buttonColor;
  Color? sliderActiveColor;
  Color? sliderInActiveColor;
  Color? popupBackgroundColor;
  Color? selectionTileColor;
  Color? pinkBackground;
  Color? dialogBackground;

  // Common Theme Data Related Properties
  Color? dividerColor;
  Color? hintColor;
  Color? errorColor;

  ButtonStyle? textButtonThemeData;
  ButtonStyle? elevatedButtonThemeDataPrimary;
  ButtonStyle? elevatedButtonThemeDataSecondary;
  ButtonStyle? elevatedButtonThemeDataHollow;
  ButtonStyle? elevatedButtonThemeDataRed;

  SwitchThemeData? switchThemeData;

  TextStyle ts = const TextStyle();

  FloatingActionButtonThemeData? floatingActionButtonThemeData;

  void initialize(ThemeMode themeMode) {
    _themeMode = themeMode;
    _setParentThemeData();
    _setCommonThemeData();
  }

  void _setParentThemeData() {
    switch (_themeMode) {
      case ThemeMode.system:
        if (PlatformDispatcher.instance.platformBrightness == Brightness.light) {
          continue light;
        }
        continue dark;
      light:
      case ThemeMode.light:
        brightness = Brightness.light;
        scaffoldBackgroundColor = scaffoldBackground;
        backgroundColor = scaffoldBackground;
        cardColor = AppColor.themeColorWhite;
        dialogBackgroundColor = scaffoldBackground;
        textFieldColor = AppColor.textFieldColorLight;
        textFieldBorderColor = AppColor.textFieldBorderColorLight;

        textHeadingColor = AppColor.textHeadingLightTheme;
        textSubHeadingColor = AppColor.textSubHeadingLightTheme;
        textColorTitle = AppColor.textTitleLightTheme;
        textColorSubTitle = AppColor.textSubTitleLightTheme;

        textColorSubTitle = AppColor.greyColor;
        disabledColor = AppColor.grayChateau;
        _setChildColorThemeDataValues(AppColor.primaryLight);

        popupBackgroundColor = AppColor.popupBackgroundLight;
        selectionTileColor = AppColor.selectionTileColorLight;
        pinkBackground = AppColor.pink;
        dialogBackground = AppColor.dialogBackgroundLight;

        switchThemeData = _switchThemeData(
          trackColor: Colors.grey.withValues(alpha: 0.5),
          thumbColor: AppColor.themeColorWhite,
        );
        dividerColor = AppColor.themeColorGrey;
        hintColor = AppColor.hintColor;
        break;
      dark:
      case ThemeMode.dark:
        brightness = Brightness.dark;
        scaffoldBackgroundColor = scaffoldBackground;
        backgroundColor = scaffoldBackground;
        cardColor = AppColor.cardBackgroundDark;
        dialogBackgroundColor = scaffoldBackground;
        textFieldColor = AppColor.textFieldColorDark;
        textFieldBorderColor = AppColor.textFieldBorderColorDark;

        textHeadingColor = AppColor.textHeadingLightTheme;
        textSubHeadingColor = AppColor.textSubHeadingLightTheme;
        textColorTitle = AppColor.textTitleDarkTheme;
        textColorSubTitle = AppColor.textSubTitleLightTheme;

        textColorSubTitle = AppColor.greyColor;
        disabledColor = AppColor.themeColorWhite.withValues(alpha: 0.16);
        _setChildColorThemeDataValues(AppColor.primaryDark);

        popupBackgroundColor = AppColor.popupBackgroundDark;
        selectionTileColor = AppColor.selectionTileColorDark;
        pinkBackground = AppColor.pink;
        dialogBackground = AppColor.dialogBackgroundDark;

        switchThemeData = _switchThemeData(
          trackColor: AppColor.white70,
          thumbColor: AppColor.themeColorWhite,
        );
        dividerColor = AppColor.themeColorGrey;
        hintColor = AppColor.hintColor;
        bottomSheetTheme:
        const BottomSheetThemeData(
          backgroundColor: Color(0xFF1C1C1E), // Slightly lighter gray for contrast
          modalBackgroundColor: Color(0xFF1C1C1E), // For modal bottom sheets
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
        );
        break;
    }

    ts = GoogleFonts.inter(color: textColorDefault);
  }

  void _setChildColorThemeDataValues(Color setThemeColor) {
    primaryColor = setThemeColor;
    shadowColor = setThemeColor.withValues(alpha: 0.5);
    bottomAppBarColor = setThemeColor;
    focusColor = setThemeColor;
    hoverColor = setThemeColor.withValues(alpha: 0.1);
    highlightColor = setThemeColor.withValues(alpha: 0.1);
    splashColor = setThemeColor.withValues(alpha: 0.1);
    buttonColor = setThemeColor;
    sliderActiveColor = setThemeColor;
    sliderInActiveColor = AppColor.steelGrey;
  }

  void _setCommonThemeData() {
    errorColor = AppColor.themeColorRed;
    textButtonThemeData = _getTextButtonStyle();
    elevatedButtonThemeDataPrimary = _getElevatedButtonStylePrimary();
    elevatedButtonThemeDataSecondary = _getElevatedButtonStyleBlueSecondary();
    elevatedButtonThemeDataHollow = _elevatedButtonStyleHollow();
    elevatedButtonThemeDataRed = _elevatedButtonStyleRed();
    floatingActionButtonThemeData = const FloatingActionButtonThemeData();
  }

  ButtonStyle _getTextButtonStyle() {
    return ButtonStyle(
      foregroundColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: primaryColor,
        disableColor: grayChateau,
      ),
      backgroundColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: Colors.transparent,
        disableColor: disabledColor!,
      ),
      overlayColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: primaryColorRippleButton,
        disableColor: grayDisable,
      ),
      textStyle: WidgetStateProperty.all(ts.extTs16.weightMedium600.copyWith(letterSpacing: letterSpacing)),
      padding: WidgetStateProperty.all(const EdgeInsets.only(left: 8.0, right: 8.0)),
      elevation: WidgetStateProperty.all(0.0),
    );
  }

  ButtonStyle _getElevatedButtonStylePrimary() => _elevatedButtonStyleCommon(_outlinedBorderButton());

  ButtonStyle _getElevatedButtonStyleBlueSecondary() => _elevatedButtonStyleCommon(_outlinedBorderButton(radius: 10.0));

  ButtonStyle _elevatedButtonStyleCommon(OutlinedBorder outlineBorder) => ButtonStyle(
        foregroundColor: WidgetStatePropertyExtension.resolveWithColor(
          defaultColor: AppColor.white90,
          disableColor: AppColor.themeColorWhite,
        ),
        backgroundColor: WidgetStatePropertyExtension.resolveWithColor(
          defaultColor: primaryColorButton,
          disableColor: disabledColor!,
        ),
        overlayColor: WidgetStatePropertyExtension.resolveWithColor(
          defaultColor: primaryColorRippleButton,
          disableColor: AppColor.themeColorWhite,
        ),
        textStyle: WidgetStateProperty.all(ts.extTs16.weightMedium600.copyWith(letterSpacing: letterSpacing)),
        elevation: WidgetStateProperty.all(0.0),
        shape: WidgetStateProperty.all(outlineBorder),
      );

  ButtonStyle _elevatedButtonStyleHollow() {
    return ButtonStyle(
      foregroundColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: textColorTextTitle,
        disableColor: AppColor.themeColorWhite,
      ),
      backgroundColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: Colors.transparent,
        disableColor: disabledColor!,
      ),
      overlayColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: inkWellRippleColorGrey.withValues(alpha: 0.4),
        disableColor: AppColor.themeColorWhite,
      ),
      textStyle: WidgetStateProperty.all(ts.extTsTitle16Regular.copyWith(letterSpacing: letterSpacing)),
      side: WidgetStateProperty.all(
        BorderSide(color: buttonHollowBorderColor),
      ),
      elevation: WidgetStateProperty.all(0.0),
      shape: WidgetStateProperty.all(_outlinedBorderButton()),
    );
  }

  ButtonStyle _elevatedButtonStyleRed() {
    return ButtonStyle(
      foregroundColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: AppColor.themeColorWhite,
        disableColor: AppColor.themeColorWhite,
      ),
      backgroundColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: elevatedButtonRedBackgroundColor,
        disableColor: disabledColor!,
      ),
      overlayColor: WidgetStatePropertyExtension.resolveWithColor(
        defaultColor: elevatedButtonRedOverlayColor,
        disableColor: AppColor.themeColorWhite,
      ),
      textStyle: WidgetStateProperty.all(ts.extTsTitle16Regular.copyWith(letterSpacing: letterSpacing)),
      elevation: WidgetStateProperty.all(0.0),
      shape: WidgetStateProperty.all(_outlinedBorderButton()),
    );
  }

  OutlinedBorder _outlinedBorderButton({double radius = 8.0}) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      );

  SwitchThemeData _switchThemeData({required Color trackColor, required Color thumbColor}) {
    return SwitchThemeData(
      trackColor: WidgetStateProperty.all(trackColor),
      thumbColor: WidgetStateProperty.all(thumbColor),
    );
  }

  static ThemeMode getThemeFromString(String name) {
    final themeName = 'ThemeMode.$name';
    return ThemeMode.values.firstWhere(
      (themeEnum) => themeEnum.toString() == themeName,
      orElse: () => ThemeMode.system,
    );
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle get subText => copyWith(color: ThemeUtils.instance.textColorDefault.withValues(alpha: 0.5));

  TextStyle get extTs48 => copyWith(fontSize: 48);

  TextStyle get extTs40 => copyWith(fontSize: 40);

  TextStyle get extTs36 => copyWith(fontSize: 36);

  TextStyle get extTs32 => copyWith(fontSize: 32);

  TextStyle get extTs24 => copyWith(fontSize: 24);

  TextStyle get extTs20 => copyWith(fontSize: 20);

  TextStyle get extTs18 => copyWith(fontSize: 18);

  TextStyle get extTs16 => copyWith(fontSize: 16);

  TextStyle get extTs15 => copyWith(fontSize: 15);

  TextStyle get extTs14 => copyWith(fontSize: 14);

  TextStyle get extTs13 => copyWith(fontSize: 13);

  TextStyle get extTs12 => copyWith(fontSize: 12);

  TextStyle get extTs11 => copyWith(fontSize: 11);

  TextStyle get extTs10 => copyWith(fontSize: 10);

  TextStyle get extTs9 => copyWith(fontSize: 9);

  TextStyle get extTs8 => copyWith(fontSize: 8);

  TextStyle get extTs18Bold => copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  TextStyle get extTsSpacing1 => copyWith(letterSpacing: 1.0);

  TextStyle get weightBold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get weightMedium600 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get weightMedium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get weightRegular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get weightLight => copyWith(fontWeight: FontWeight.w300);

  TextStyle get weightSuperLight => copyWith(fontWeight: FontWeight.w200);

  TextStyle get weightThin => copyWith(fontWeight: FontWeight.w100);

  TextStyle get colorPrimary => copyWith(color: ThemeUtils.instance.primaryColor);

  TextStyle get colorTextTab => copyWith(color: ThemeUtils.instance.textColorTextTitle);

  TextStyle get colorSteelGrey => copyWith(color: AppColor.steelGrey);

  TextStyle get colorMediumGrey => copyWith(color: ThemeUtils.instance.mediumGreyColor);

  TextStyle get colorTsThemeRed => copyWith(color: ThemeUtils.instance.themeColorRed);

  TextStyle get colorTsThemeBlack => copyWith(color: ThemeUtils.instance.themeColorBlack);

  TextStyle get colorTsThemePrimary => copyWith(color: ThemeUtils.instance.primaryColor);

  //TextStyle get colorTsThemeBlue => copyWith(color: ThemeUtils.instance.themeColorBlue);

  TextStyle get colorTsThemeGrey => copyWith(color: ThemeUtils.instance.themeColorGrey);

  TextStyle get colorGreenText => copyWith(color: ThemeUtils.instance.greenColor);

  TextStyle get colorRedText => copyWith(color: ThemeUtils.instance.redColor);

  TextStyle get colorIconGrey => copyWith(color: ThemeUtils.instance.themeColorIcon);

  TextStyle get colorWeblink => copyWith(color: ThemeUtils.instance.weblinkColor);

  TextStyle get colorWhite => copyWith(color: ThemeUtils.instance.whiteColor);

  TextStyle get colorSkin => copyWith(color: ThemeUtils.instance.skinColor);

  TextStyle get extColorDefault => copyWith(color: ThemeUtils.instance.textColorDefault);

  TextStyle get color15 => copyWith(color: color?.withValues(alpha: 0.15));

  TextStyle get color25 => copyWith(color: color?.withValues(alpha: 0.25));

  TextStyle get color50 => copyWith(color: color?.withValues(alpha: 0.50));

  TextStyle get color75 => copyWith(color: color?.withValues(alpha: 0.75));

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get height22 => copyWith(height: 22 / (fontSize ?? 22));

  TextStyle get height24 => copyWith(height: 24 / (fontSize ?? 24));

  TextStyle get height40 => copyWith(height: 40 / (fontSize ?? 40));

  TextStyle get extColorGrayChateau => copyWith(color: ThemeUtils.instance.grayChateau);

  TextStyle get extTsTitle16Regular => extTs16.weightRegular.extColorDefault;

  TextStyle get extTsTitle16Medium => extTs16.weightMedium.extColorDefault;
}

extension ThemeUtilsExtension on ThemeUtils {
  bool get isDark => brightness == Brightness.dark;

  // App Using Colors

  Color get primaryColor => isDark ? AppColor.primaryDark : AppColor.primaryLight;

  Color get primaryColorButton => isDark ? primaryColor.withValues(alpha: 0.8) : primaryColor.withValues(alpha: 0.8);

  Color get primaryColorRippleButton => primaryColor;

  Color get backgroundColor => isDark ? AppColor.backgroundDark : AppColor.backgroundLight;

  // Extra Colors
  //Color get inkWellRippleColorBlue => AppColor.themeColorBlueRipple;

  Color get inkWellRippleColorGrey => isDark ? AppColor.themeColorBlack.withValues(alpha: 0.6) : AppColor.themeColorGreyRipple.withValues(alpha: 0.5);

  Color get inkWellRippleColorCommon => isDark ? AppColor.themeColorGreyRipple.withValues(alpha: 0.7) : AppColor.themeColorGreyRipple.withValues(alpha: 0.4);

  Color get grayDisable => isDark ? AppColor.grayDisableDark : AppColor.grayDisableLight;

  Color get grayChateau => isDark ? AppColor.grayChateauDark : AppColor.grayChateauLight;

  /*Color get elevatedButtonMainBackgroundColor => AppColor.themeColorBlue;

  Color get elevatedButtonBlueBackgroundColor => AppColor.themeColorBlue;*/

  Color get elevatedButtonRedBackgroundColor => AppColor.themeColorRed;

  Color get elevatedButtonRedOverlayColor => AppColor.themeColorRed.withValues(alpha: 0.8);

  Color get elevatedButtonBlueSmallBackgroundColor => isDark ? AppColor.themeColorBlue.withValues(alpha: 0.5) : AppColor.themeColorBlue;

  Color get elevatedButtonBlueSmallTextColor => isDark ? AppColor.themeColorBlue : AppColor.themeColorWhite;

  Color get themePrimaryActiveColor => isDark ? AppColor.backgroundLight : AppColor.backgroundDark;

  Color get scaffoldBackground => isDark ? AppColor.backgroundDark : AppColor.backgroundLight;

  Color get scaffoldBackgroundTemp => isDark ? AppColor.themeColorBlack : AppColor.themeColorWhite;

  Color get textColorDefault => isDark ? AppColor.themeColorWhite : AppColor.themeColorBlack;

  Color get textColorTextTitle => isDark ? AppColor.white90 : AppColor.themeColorBlack;

  Color get textColorTextTab => isDark ? AppColor.white50 : AppColor.black50;

  Color get buttonHollowBorderColor => isDark ? AppColor.themeColorWhite : AppColor.themeColorBlack;

  Color get colorInfoWidgetBorder => isDark ? AppColor.primaryDark : AppColor.grayDisableLight;

  Color get chipBackgroundColor => isDark ? AppColor.primaryDark : AppColor.themeColorWhite;

  //New Text Colors:
  Color get mediumGreyColor => isDark ? AppColor.themeLightGrey : AppColor.themeLightGrey;

  Color get themeColorRed => isDark ? AppColor.themeColorRed : AppColor.themeColorRed;

  Color get themeColorGreen => isDark ? AppColor.themeColorGreen : AppColor.themeColorGreen;

  Color get themeColorBlack => isDark ? darkModeWhiteColor : AppColor.themeColorBlack;

  Color get themeColorTabDividerColor => isDark ? AppColor.black30 : AppColor.themeColorGrey;

  //Color get themeColorIcon => isDark ? darkModeWhiteColor : AppColor.themeColorIcon;
  Color get themeColorIcon => isDark ? darkModeWhiteColor : AppColor.themeColorBlack.withValues(alpha: 0.8);

  Color get bottomActiveColor => isDark ? AppColor.themeColorWhite : AppColor.themeColorBlack.withValues(alpha: 0.7);

  Color get bottomInActiveColor => isDark ? darkModeWhiteColor : iconGreyColor;

  Color get darkModeWhiteColor => AppColor.themeColorWhite.withValues(alpha: 0.7);

  Color get iconColorWhite => isDark ? AppColor.themeColorWhite : AppColor.themeColorWhite;

  Color get themeColorCreateFeedPoppins => isDark ? AppColor.black30 : AppColor.themeColorGrey;

  Color get themeColorGrey => isDark ? AppColor.black40 : AppColor.themeColorGrey;

  Color get themeColorGreyLight => isDark ? darkModeWhiteColor : AppColor.themeColorGreyRipple;

  Color get shimmerColorBase => isDark ? AppColor.instance.shimmerColorBaseDark : AppColor.instance.shimmerColorBaseLight;

  Color get shimmerColorHighlight => isDark ? AppColor.instance.shimmerColorHighlightDark : AppColor.instance.shimmerColorHighlightLight;

  Color get tabSelectedColor => isDark ? AppColor.white20 : AppColor.themeColorBlue.withValues(alpha: 0.5);

  Color get tabUnSelectedColor => AppColor.greyColor.withValues(alpha: 0.5);

  Color get iconGreyColor => isDark ? AppColor.iconGreyColor : AppColor.iconGreyColor;

  Color get skinColor => isDark ? AppColor.themeColorSkin : AppColor.themeColorSkin;

  Color get lightGreyTextColor => isDark ? AppColor.lightGreyTextColor : AppColor.lightGreyTextColor;

  Color get redColor => isDark ? AppColor.themeColorRed : AppColor.themeColorRed;

  Color get lightBlueColor => isDark ? AppColor.lightBlueColor : AppColor.lightBlueColor;

  Color get weblinkColor => isDark ? AppColor.themeColorWebLinkDarkMode : AppColor.themeColorWebLinkLightMode;

  Color get greenColor => isDark ? AppColor.green : AppColor.green;

  Color get whiteColor => isDark ? AppColor.themeColorWhite : AppColor.themeColorWhite;

  double get defaultCornerRadiusInt => 8.0;

  BorderRadius get defaultBorderRadius => BorderRadius.circular(defaultCornerRadiusInt);

  BoxDecoration get greyDecoration => BoxDecoration(
        border: Border.all(color: grayDisable, width: 0.5),
        borderRadius: defaultBorderRadius,
        color: scaffoldBackgroundTemp,
      );

  BoxDecoration get greenDecoration => BoxDecoration(
        border: Border.all(color: AppColor.themeColorGreen, width: 0.5),
        borderRadius: defaultBorderRadius,
        color: AppColor.themeColorGreen,
      );

  BoxDecoration get redDecoration => BoxDecoration(
        border: Border.all(color: AppColor.themeColorRed, width: 0.5),
        borderRadius: defaultBorderRadius,
        color: AppColor.themeColorRed,
      );

  OutlineInputBorder get inputFieldDecoration => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: textFieldBorderColor ?? Colors.transparent,
          width: 0.5,
        ),
      );

  OutlineInputBorder get inputFieldErrorDecoration => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColor.errorRed),
      );

  BoxDecoration get boxDecorationInfoWidget {
    final backgroundColor = isDark ? AppColor.themeColorContainerDecorationDark : AppColor.themeColorContainerDecorationLight;
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(22.0),
      border: isDark ? null : Border.all(color: backgroundColor, width: 0.5),
      boxShadow: isDark
          ? null
          : const [
              BoxShadow(
                color: AppColor.cardDropShadow,
                blurRadius: 3.0,
              ),
            ],
    );
  }

  BoxDecoration get boxDecorationTileWidget {
    final backgroundColor = cardColor;
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  BoxDecoration get feedCardForegroundDecoration => BoxDecoration(
        color: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.0),
      );

  BoxDecoration get chipForegroundDecorationExpert => BoxDecoration(
        color: isDark ? AppColor.themeColorGolden.withValues(alpha: 0.5) : AppColor.themeColorGolden.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(100.0),
      );

  BoxDecoration boxDecorationSelectionTileWidget(bool isSelected) => BoxDecoration(
        color: selectionTileColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? primaryColor : Colors.transparent,
        ),
        boxShadow: isDark
            ? null
            : const [
                BoxShadow(
                  color: AppColor.cardItemBorder,
                  blurRadius: 2.0,
                ),
              ],
      );

  InputDecoration inputDecorationMain({required bool isError}) {
    final border = isError ? inputFieldErrorDecoration : inputFieldDecoration;

    return InputDecoration(
      errorStyle: const TextStyle(fontSize: 0),
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      contentPadding: const EdgeInsets.all(16.0),
      isDense: true,
    );
  }
}

extension EnumAppThemeExtension on ThemeMode {
  String get name => toString().split('.').last;

  ThemeMode get opposite => this == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;
}

class WidgetStatePropertyExtension {
  static const interactiveStatesDefault = <WidgetState>{
    WidgetState.pressed,
    WidgetState.hovered,
    WidgetState.focused,
  };

  static const interactiveStatesDisable = <WidgetState>{
    WidgetState.disabled,
  };

  static Color _getColor(
    Set<WidgetState> states, {
    required Color defaultColor,
    required Color disableColor,
    Color? pressedColor,
  }) {
    if (states.any(interactiveStatesDefault.contains)) {
      return pressedColor ?? defaultColor;
    } else if (states.any(interactiveStatesDisable.contains)) {
      return disableColor;
    }
    return defaultColor;
  }

  static WidgetStateProperty<Color?>? resolveWithColor({
    required Color defaultColor,
    required Color disableColor,
    Color? pressedColor,
  }) =>
      WidgetStateProperty.resolveWith(
        (states) => _getColor(
          states,
          defaultColor: defaultColor,
          disableColor: disableColor,
          pressedColor: pressedColor,
        ),
      );
}
