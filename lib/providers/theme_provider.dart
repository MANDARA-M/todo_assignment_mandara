import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/app_color.dart';
import '../firebase/appInsights/event_logger.dart';
import '../theme/theme_utils.dart';
import '../utilities/storage/shared_preference/shared_preferences_util.dart';
import 'utils/provider_utility.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;
  late ThemeData _themeData;

  void initializeThemeMetaData() {
    _themeMode = SharedPreferencesUtil.instance.getAppTheme();
    ThemeUtils.instance.initialize(_themeMode);
    _themeData = _getAppThemeModel();
  }

  Future<void> _setAppTheme(ThemeMode themeMode) async {
    await EventLogger.instance.changeTheme(themeMode);

    _themeMode = themeMode;
    await SharedPreferencesUtil.instance.saveAppTheme(_themeMode);
    ThemeUtils.instance.initialize(_themeMode);

    _themeData = _getAppThemeModel();

    final statusBarColor = ThemeUtils.instance.brightness == Brightness.light ? AppColor.primaryLight : Colors.black;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: statusBarColor),
    );
    notifyListeners();
  }

  ThemeData _getAppThemeModel() {
    final themeUtilsData = ThemeUtils.instance;

    final _fillColor = WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return themeUtilsData.primaryColor;
      }
      return null;
    });

    return ThemeData(
      colorSchemeSeed: themeUtilsData.primaryColor,
      unselectedWidgetColor: themeUtilsData.disabledColor,
      indicatorColor: themeUtilsData.primaryColor,
      dialogBackgroundColor: themeUtilsData.dialogBackgroundColor,
      shadowColor: themeUtilsData.shadowColor,
      scaffoldBackgroundColor: themeUtilsData.scaffoldBackgroundColor,
      bottomAppBarTheme: BottomAppBarThemeData(color: themeUtilsData.bottomAppBarColor),
      focusColor: themeUtilsData.focusColor,
      hoverColor: themeUtilsData.hoverColor,
      highlightColor: themeUtilsData.highlightColor,
      splashColor: themeUtilsData.splashColor,
      disabledColor: themeUtilsData.disabledColor,
      dividerColor: themeUtilsData.dividerColor,
      hintColor: themeUtilsData.hintColor,
      textTheme: GoogleFonts.interTextTheme(TextTheme(
        titleSmall: const TextStyle().copyWith(color: ThemeUtils.instance.mediumGreyColor),
      )),
      fontFamily: GoogleFonts.inter().fontFamily,
      textButtonTheme: TextButtonThemeData(style: themeUtilsData.textButtonThemeData),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: themeUtilsData.textFieldColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: AppColor.themeColorGrey),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.themeColorGrey),
          borderRadius: BorderRadius.circular(14.0),
        ),
        labelStyle: const TextStyle(
          color: AppColor.themeColorBlack,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: TextStyle(
          color: themeUtilsData.hintColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: themeUtilsData.elevatedButtonThemeDataPrimary,
      ),
      floatingActionButtonTheme: themeUtilsData.floatingActionButtonThemeData,
      buttonTheme: ButtonThemeData(
        buttonColor: themeUtilsData.primaryColor.withValues(alpha: 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
            color: themeUtilsData.primaryColor,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.inter(
          textStyle: TextStyle(color: themeUtilsData.textColorTitle),
        ),
        centerTitle: true,
        backgroundColor: themeUtilsData.backgroundColor,
        elevation: 0.4,
        iconTheme: IconThemeData(color: themeUtilsData.textColorTitle),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: themeUtilsData.backgroundColor,
      ),
      tabBarTheme: TabBarThemeData(
        dividerColor: themeUtilsData.themeColorTabDividerColor,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          //color: AppColor.themeColorSaffron,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: themeUtilsData.textColorTitle,
        ),
        indicator: UnderlineTabIndicator(borderSide: BorderSide(color: themeUtilsData.primaryColor)),
      ),
      sliderTheme: SliderThemeData(
        activeTickMarkColor: themeUtilsData.sliderActiveColor,
        inactiveTickMarkColor: themeUtilsData.sliderInActiveColor,
        disabledActiveTickMarkColor: themeUtilsData.sliderInActiveColor,
        activeTrackColor: themeUtilsData.sliderActiveColor,
        inactiveTrackColor: themeUtilsData.sliderInActiveColor,
        disabledActiveTrackColor: themeUtilsData.sliderActiveColor?.withValues(alpha: 0.5),
        disabledInactiveTickMarkColor: themeUtilsData.sliderInActiveColor,
        thumbColor: themeUtilsData.sliderActiveColor,
        overlayColor: themeUtilsData.sliderActiveColor?.withValues(alpha: 0.5),
      ),
      cardTheme: CardThemeData(
        color: themeUtilsData.cardColor,
        elevation: 1.0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.themeColorGrey, width: 0.05),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        fillColor: _fillColor,
      ),
      switchTheme: themeUtilsData.switchThemeData,
      radioTheme: RadioThemeData(
        fillColor: _fillColor,
      ),
      splashFactory: InkRipple.splashFactory,
      //colorScheme: ColorScheme(background: themeUtilsData.backgroundColor),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: themeUtilsData.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
      ),
    );
  }

  static ThemeProvider of(WidgetRef ref) => ref.watch(themeProvider);
}

extension ThemeProviderExtension on ThemeProvider {
  bool get isDark => _themeMode == ThemeMode.dark;

  ThemeMode get appTheme => _themeMode;

  ThemeData? get themeData => _themeData;

  void changeAppThemeRead(ThemeMode changeThemeTo) => _setAppTheme(changeThemeTo);

  void toggleTheme() => changeAppThemeRead(_themeMode.opposite);

  void activateDarkTheme({required bool isDarkTheme}) => changeAppThemeRead(isDarkTheme ? ThemeMode.dark : ThemeMode.light);

  ButtonStyle? get buttonPrimary => ThemeUtils.instance.elevatedButtonThemeDataPrimary;

  ButtonStyle? get buttonSecondary => ThemeUtils.instance.elevatedButtonThemeDataSecondary;

  ButtonStyle? get buttonTextTertiary => ThemeUtils.instance.textButtonThemeData;

  ButtonStyle? get buttonHollow => ThemeUtils.instance.elevatedButtonThemeDataHollow;

  ButtonStyle? get buttonRed => ThemeUtils.instance.elevatedButtonThemeDataRed;

  TextStyle get ts => ThemeUtils.instance.ts;

  TextStyle? get tsTextSmall => themeData?.textTheme.titleSmall;

  Color get primaryColor => ThemeUtils.instance.primaryColor;

  Color get inkWellRippleColorGrey => ThemeUtils.instance.inkWellRippleColorGrey;

  Color get inkWellRippleColorCommon => ThemeUtils.instance.inkWellRippleColorCommon;

  Color get grayDisable => ThemeUtils.instance.grayDisable;

  Color get grayChateau => ThemeUtils.instance.grayChateau;

  Color get scaffoldBackgroundTemp => ThemeUtils.instance.scaffoldBackgroundTemp;

  Color get scaffoldBackground => ThemeUtils.instance.scaffoldBackground;

  Color? get backgroundColor => ThemeUtils.instance.backgroundColor;

  Color get textColor => ThemeUtils.instance.textColorDefault;

  Color get textColorWhite => ThemeUtils.instance.whiteColor;

  Color get themeColorTabDividerColor => ThemeUtils.instance.themeColorTabDividerColor;

  Color get actionIconColor => ThemeUtils.instance.themeColorIcon;

  Color get actionIconColorSelected => ThemeUtils.instance.primaryColor;

  Color getBottomSheetActionColor(bool isSelected) => isSelected ? ThemeUtils.instance.bottomActiveColor : ThemeUtils.instance.bottomInActiveColor;

  Color get weblinkColor => ThemeUtils.instance.weblinkColor;

  Color get iconColor => ThemeUtils.instance.textColorDefault;

  Color? get popupBackground => ThemeUtils.instance.popupBackgroundColor;

  Color? get selectionTileColor => ThemeUtils.instance.selectionTileColor;

  Color get hollowButtonBorderColor => ThemeUtils.instance.buttonHollowBorderColor;

  Color get chipBackgroundColor => ThemeUtils.instance.chipBackgroundColor;

  Color? get textFieldColor => ThemeUtils.instance.textFieldColor;

  Color? get textFieldBorderColor => ThemeUtils.instance.textFieldBorderColor;

  Color? get cardColor => ThemeUtils.instance.cardColor;

  Color get themeColorCreateFeedPoppins => ThemeUtils.instance.themeColorCreateFeedPoppins;

  Color get themeColorGrey => ThemeUtils.instance.themeColorGrey;

  Color get themeColorGreyLight => ThemeUtils.instance.themeColorGreyLight;

  Color get themeColorRed => ThemeUtils.instance.themeColorRed;

  Color get themeColorGreen => ThemeUtils.instance.themeColorGreen;

  Color get shimmerColorBase => ThemeUtils.instance.shimmerColorBase;

  Color get shimmerColorHighlight => ThemeUtils.instance.shimmerColorHighlight;

  Color get tabSelectedColor => ThemeUtils.instance.tabSelectedColor;

  Color get tabUnSelectedColor => ThemeUtils.instance.tabUnSelectedColor;

  Color get darkModeWhiteColor => ThemeUtils.instance.darkModeWhiteColor;

  Color getSelectedIconColor({required bool isSelected, bool isDetailScreen = false}) => isSelected ? actionIconColorSelected : (isDetailScreen ? darkModeWhiteColor : actionIconColor);

  Color getFollowSelectedThemeColor(bool isFollowed) => isFollowed ? AppColor.white70 : AppColor.darkBlackColor;

  Color getBottomChipColor(int index) => AppColor.instance.getBottomChipColor(index);

  Color get textColorTextTitle => ThemeUtils.instance.textColorTextTitle;

  Color? get pinkBackground => ThemeUtils.instance.pinkBackground;

  Color? get dialogBackground => ThemeUtils.instance.dialogBackground;

  Color? get lightYellowColor => isDark ? AppColor.cardBackgroundDark : AppColor.lightYellowColor;

  Decoration get greyDecoration => ThemeUtils.instance.greyDecoration;

  Decoration get greenDecoration => ThemeUtils.instance.greenDecoration;

  Decoration get redDecoration => ThemeUtils.instance.redDecoration;

  BoxDecoration get boxDecorationInfoWidget => ThemeUtils.instance.boxDecorationInfoWidget;

  BoxDecoration get boxDecorationTileWidget => ThemeUtils.instance.boxDecorationTileWidget;

  BoxDecoration get feedCardForegroundDecoration => ThemeUtils.instance.feedCardForegroundDecoration;

  BoxDecoration get chipForegroundDecoration => ThemeUtils.instance.chipForegroundDecorationExpert;

  BoxDecoration boxDecorationSelectionTileWidget(bool isSelected) => ThemeUtils.instance.boxDecorationSelectionTileWidget(isSelected);

  InputDecoration inputDecorationMain({required bool isError}) => ThemeUtils.instance.inputDecorationMain(isError: isError);
}
