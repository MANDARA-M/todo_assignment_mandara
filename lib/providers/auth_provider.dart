import 'dart:async';

import 'package:flutter/material.dart';

import '../firebase/appInsights/event_logger.dart';
import '../navigation/navigation_utils.dart';
import '../network/models/response/login/response_login.dart';
import '../network/models/response/user/response_user.dart';
import '../network/models/response/user/user.dart';
import '../utilities/storage/shared_preference/shared_preferences_util.dart';

typedef LoginSuccess = void Function(ResponseUserData? session);
typedef NotLoggedIn = void Function();

class AuthProvider extends ChangeNotifier {
  ResponseUserData? _session = SharedPreferencesUtil.instance.sessionData;

  ResponseUserData? get session => _session;

  User? get user => _session?.user;

  int get userId => user?.userId ?? 0;

  bool get isUserLoggedIn => _session?.isUserLoggedIn ?? false;

  bool get isUserNotLoggedIn => !isUserLoggedIn;

  Future<void> initialize() async {
    _session = SharedPreferencesUtil.instance.sessionData;

    if (_session != null) {
      await setSession(_session!, refresh: false);
    } else {}
  }

  void observerLogin(BuildContext context, {LoginSuccess? loginSuccess, NotLoggedIn? notLoggedIn}) {
    if (isUserLoggedIn && session?.user.userId != null) {
      loginSuccess?.call(_session);
    } else {
      notLoggedIn?.call();
      NavigationUtils.instance.moveToLoginScreen(context: context);
    }
  }

  Future<ResponseLogin?> login(String mobile) async {
    return null;
  }

  Future<void> resendOtp({required String mobile}) async {}

  Future<ResponseUserData?> verifyOtp({required String mobile, required String otp}) async {
    return null;
  }

  Future<void> setSession(ResponseUserData userData, {bool refresh = true}) async {
    if (_session != null) {
      userData.token ??= _session!.token;
      userData.refreshToken ??= _session!.refreshToken;
    }

    _session = userData;

    await SharedPreferencesUtil.instance.setSession(userData);
    await EventLogger.instance.setSession(phoneNumber: userData.user.mobile);
    if (refresh) {
      notifyListeners();
    }
  }

  void setUser(User? user) {
    if (user != null) {
      _session?.setUser(user);
      if (session != null) {
        setSession(_session!);
      }
    }
  }

  Future<void> _logoutSession() async {
    _session = null;
    await EventLogger.instance.setSession(phoneNumber: '');
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    final userMobile = user?.mobile;
    // Firebase call to logout
    await SharedPreferencesUtil.instance.logout();
    await _logoutSession();
  }
}
