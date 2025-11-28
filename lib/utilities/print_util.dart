import 'package:logger/logger.dart';

class PrintUtils {
  // singelton class
  PrintUtils._();

  static final PrintUtils instance = PrintUtils._();

  final tagLog = 'inSTA ->';

  var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 0,
        lineLength: 160,
        noBoxingByDefault: true,
        printEmojis: false
    ),
  );

  void printLog(String message) {
    logger.d(_formattedMessage(message));
  }

  void printInformation(String message) {
    logger.i(_formattedMessage(message));
  }

  void printWarning(String message) {
    logger.w(_formattedMessage(message));
  }

  void printException(Object e) {
    logger.e('$tagLog $e');
  }

  void printError(String message) {
    logger.e(_formattedMessage(message));
  }

  void printFatal(String message) {
    logger.e(_formattedMessage(message));
  }

  String _formattedMessage(String message) => message;
}
