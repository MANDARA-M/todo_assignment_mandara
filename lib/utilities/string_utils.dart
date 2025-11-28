class StringUtils {

  static const String KEY_LANGUAGE_pleaseWait = 'KEY_LANGUAGE_pleaseWait';
  static const String KEY_LANGUAGE_ok = 'KEY_LANGUAGE_ok';
  static const String KEY_LANGUAGE_cancel = 'KEY_LANGUAGE_cancel';

  static const String KEY_MALE = 'Male';
  static const String KEY_FEMALE = 'Female';

  static bool contains(String toCheck, String inString,
      {bool isEqualIgnoreCase = true}) {
    try {
      if (isEqualIgnoreCase) {
        return inString.toLowerCase().contains(toCheck.toLowerCase());
      } else {
        return inString.contains(toCheck);
      }
    } catch (e) {
      e.toString();
    }
    return false;
  }

  static bool exact(String toCheck, String withCheck,
      {bool isEqualIgnoreCase = true}) {
    try {
      if (isEqualIgnoreCase) {
        return toCheck.toLowerCase() == (withCheck.toLowerCase());
      } else {
        return toCheck == withCheck;
      }
    } catch (e) {
      e.toString();
    }
    return false;
  }

  static int? convertToInt(String? value) {
    try {
      return value != null ? int.parse(value) : null;
    } catch (e) {
      return null;
    }
  }

  static bool isValidEmail(String value) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
