import 'package:share_plus/share_plus.dart';
import 'package:sprintf/sprintf.dart';

import '../l10n/app_localizations.dart';

class ShareUtils {
  ShareUtils._();

  static ShareUtils? _instance;

  static final ShareUtils instance = _instance ??= ShareUtils._();

  void shareTodo({required AppLocalizations localization, required String code}) {
    final textToShare = sprintf(localization.sharePostText, [code]);
    _shareText(textToShare);
  }

  void _shareText(String text, {String title = '', String? subject}) {
    final params = ShareParams(text: text, title: title, subject: subject);
    SharePlus.instance.share(params);
  }
}
