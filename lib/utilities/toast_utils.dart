import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  ToastUtils._();

  static final instance = ToastUtils._();

  static const bool _isDebug = kDebugMode;

  void showToastDebug({required String message}) {
    if (_isDebug) {
      _showToast(message: message);
    }
  }

  void showToastRelease({required String message}) {
    if (message.isNotEmpty) {
      _showToast(message: message);
    }
  }

  void _showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white70,
      fontSize: 16.0,
    );
  }

  void showSnackBar({required BuildContext context, required String message, String title = '', ContentType contentType = ContentType.failure}) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(title: title, message: message, contentType: contentType),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showMaterialBanner({required BuildContext context, required String message, String title = '', ContentType contentType = ContentType.success}) {
    final materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(title: title, message: message, contentType: contentType, inMaterialBanner: true),
      actions: const [SizedBox.shrink()],
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  void hideCurrentSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void hideCurrentMaterialBanner(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  void hideAllSnackBars(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void showSnackBarWithAction({
    required BuildContext context,
    required String message,
    required SnackBarAction action,
    String title = 'testing',
    ContentType contentType = ContentType.success,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      //backgroundColor: Colors.transparent,
      /*content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),*/
      content: Text(message),
      action: action,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
