import 'package:intl/intl.dart';

class DateTimeUtils {
  static var instance = DateTimeUtils();

  final String commonFormattedDateApp = 'MMMM dd, yyyy';

  int get currentMillisecondsSinceEpoch => DateTime.now().millisecondsSinceEpoch;

  String get currentFormattedDateApp => getFormattedDateAppCommon(DateTime.now(), overrideFormat: 'MMMM dd, yyyy hh:mm a');

  String getCurrentFormattedTime({required int timeStampMillis}) =>
      getFormattedDateAppCommon(DateTime.fromMillisecondsSinceEpoch(timeStampMillis), overrideFormat: 'hh:mm a');

  String getCurrentFormattedDate({required int timeStampMillis}) =>
      getFormattedDateAppCommon(DateTime.fromMillisecondsSinceEpoch(timeStampMillis), overrideFormat: 'MMMM dd, yyyy');

  String getFormattedDateOnEventCard(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
  }

  int getFormattedDateAppCommonMillis(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  String getFormattedDateAppCommon(DateTime dateTime, {String? overrideFormat}) {
    final formatter = DateFormat(overrideFormat ?? commonFormattedDateApp);
    return formatter.format(dateTime);
  }

  DateTime? getFormattedDateAppCommonFromApi(String? dateValue) {
    if (dateValue == null) {
      return null;
    }

    try {
      final formatter = DateFormat(commonFormattedDateApp);
      return formatter.parse(dateValue);
    } catch (e) {
      return null;
    }
  }

  DateTime getFormattedDateAppCommonFromApiFromMillis({required int millisecondsSinchEpoch}) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinchEpoch);

  String? _getFormattedDateFromApi(int? millisecondsSinchEpoch) {
    try {
      final formatter = DateFormat(commonFormattedDateApp);
      return formatter.format(DateTime.fromMillisecondsSinceEpoch(millisecondsSinchEpoch!));
    } catch (e) {
      return null;
    }
  }

  String? formatTimeDate({required int timeStampMillis}) => _getFormattedDateFromApi(timeStampMillis);

  String? getFormattedDateStringToApiIso8601(String? dateValue) => getFormattedDateAppCommonFromApi(dateValue)?.toIso8601String();

  String getFormattedDateCurrentDayOfWeek(DateTime dateTime) => DateFormat('EEEE', 'en_US').format(dateTime);

  static bool isDateInFuture({required int millis}) {
    if (millis <= 0) {
      return false;
    }
    final now = DateTime.now();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return dateTime.isAfter(now);
  }

  static bool _isDateCalculator({required int millis, required int daysDifference}) {
    if (millis <= 0) {
      return false;
    }
    final now = DateTime.now();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day + daysDifference;
  }

  static bool isDateToday({required int millis}) => _isDateCalculator(millis: millis, daysDifference: 0);

  static bool isDateTomorrow({required int millis}) => _isDateCalculator(millis: millis, daysDifference: 1);

  static bool isDateYesterday({required int millis}) => _isDateCalculator(millis: millis, daysDifference: -1);
}
