import 'dart:async';
import 'package:restart/restart.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inSTA/utilities/print_util.dart';

import '../enums/app_enums.dart';
import '../firebase/appInsights/event_logger.dart';
import '../navigation/navigation_utils.dart';
import '../utilities/storage/shared_preference/shared_preferences_util.dart';

typedef LoginSuccess = void Function(User? user);
typedef NotLoggedIn = void Function();

class AuthenticationProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  LoginState _loginState = LoginState.initial;

  LoginState get loginState => _loginState;

  OtpVerificationState _otpVerificationState = OtpVerificationState.initial;

  OtpVerificationState get otpVerificationState => _otpVerificationState;

  String? _verificationId;
  int? _forceResendToken;

  User? _user = SharedPreferencesUtil.instance.user;

  User? get user => _user;

  String get userId => SharedPreferencesUtil.instance.userId;

  bool get isUserLoggedIn => SharedPreferencesUtil.instance.isLogin;

  bool get isUserNotLoggedIn => !isUserLoggedIn;

  Future<void> initializeUser() async {
    _user = SharedPreferencesUtil.instance.user;

    if (_user != null) {
      await _setSession(_user!, refresh: false);
    } else {}
  }

  Future<void> _setSession(User user, {bool refresh = true}) async {
    final mobile = user.phoneNumber;
    if (mobile != null) {
      await EventLogger.instance.setSession(phoneNumber: mobile);
      if (refresh) {
        notifyListeners();
      }
    }
  }

  void observerLogin(BuildContext context, {LoginSuccess? loginSuccess, NotLoggedIn? notLoggedIn}) {
    if (isUserLoggedIn) {
      loginSuccess?.call(_user);
    } else {
      notLoggedIn?.call();
      NavigationUtils.instance.moveToLoginScreen(context: context);
    }
  }

  void _changeLoginState({required LoginState state}) {
    _loginState = state;
    PrintUtils.instance.printWarning('_changeLoginState() -> $state');
    notifyListeners();
  }

  Future<void> login({required String phone}) async {
    _changeLoginState(state: LoginState.loading);

    final formattedPhone = '+91$phone';

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        forceResendingToken: _forceResendToken,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final userCredential = await _auth.signInWithCredential(credential);
            if (userCredential.user != null) {
              initializeUser();
              _changeLoginState(state: LoginState.success);
            }
          } catch (e) {
            _changeLoginState(state: LoginState.failure);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          _changeLoginState(state: LoginState.failure);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _forceResendToken = resendToken;
          _changeLoginState(state: LoginState.codeSent);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          _changeLoginState(state: LoginState.timeout);
        },
      );
    } catch (e) {
      _changeLoginState(state: LoginState.failure);
    }
  }

  Future<void> resendOtp({required String mobile}) async => login(phone: mobile);

  void _changeOtpVerificationState({required OtpVerificationState state}) {
    _otpVerificationState = state;
    notifyListeners();
  }

  Future<void> verifyOtp({required String otp}) async {
    if (_verificationId == null) {
      return;
    }

    _changeOtpVerificationState(state: OtpVerificationState.loading);

    try {
      final credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);

      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        initializeUser();
        _changeOtpVerificationState(state: OtpVerificationState.success);
      }
    } on FirebaseAuthException catch (e) {
      _changeOtpVerificationState(state: OtpVerificationState.failure);
    } catch (e) {
      _changeOtpVerificationState(state: OtpVerificationState.failure);
    }
  }

  Future<void> _logoutSession() async {
    _verificationId = null;
    _user = null;
    await EventLogger.instance.setSession(phoneNumber: '');
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await SharedPreferencesUtil.instance.logout();
    await _logoutSession();
    await restart();
  }
}
