import 'dart:ui';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppEnums {}

enum BottomSheetEventOptionsUI { poppins, listTile }

enum Language {
  Kannada(languageCode: 'kn', languageName: 'ಕನ್ನಡ'),
  English(languageCode: 'en', languageName: 'English'),
  Hindi(languageCode: 'hi', languageName: 'हिन्दी');

  const Language({required this.languageCode, required this.languageName});

  final String languageCode;
  final String languageName;
}

enum TodoScreenType { created, joined }

enum ProviderState { initial, loading, success, failure, empty }

enum LoginState { initial, loading, success, failure, codeSent, timeout }

enum OtpVerificationState { initial, loading, success, failure }

enum TaskStatus {
  open(label: 'open', icon: FluentIcons.circle_24_filled, color: Colors.blue),
  completed(label: 'completed', icon: FluentIcons.checkmark_circle_24_filled, color: Colors.green),
  none(label: 'none', icon: FluentIcons.circle_24_filled, color: Colors.blue);

  const TaskStatus({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;

  static TaskStatus fromBool(bool value) {
    return value ? completed : open;
  }
}
