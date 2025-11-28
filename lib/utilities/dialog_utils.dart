import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class DialogUtils {
  static AlertDialog? _progress;

  static void showProgress(BuildContext context, {String msg = 'Please wait'}) {
    if (_progress == null) {
      final bodyProgress = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: AppColor.themeColorGrey.withValues(alpha: 0.5),
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.themeColorGrey.withValues(alpha: 0.5)),
            strokeWidth: 2.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 25.0),
            child: Text(
              msg,
              style: TextStyle(
                color: AppColor.themeColorGrey,
              ),
            ),
          ),
        ],
      );
      _progress = AlertDialog(
        content: bodyProgress,
      );
    }
    if (_progress != null) {
      showDialog<void>(context: context, builder: (context) => _progress!, barrierDismissible: false);
    }
  }

  static void hideProgress(BuildContext context) {
    if (_progress != null) {
      Navigator.pop(context);
      _progress = null;
    }
  }
}
