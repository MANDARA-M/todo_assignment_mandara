import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/utilities/app_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common_widgets/button_widget.dart';
import '../../constants/app_color.dart';
import '../../constants/margin.dart';
import '../../extensions/state_extensions.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/navigation_utils.dart';
import '../../network/models/response/login/response_login.dart';
import '../../network/models/response/login/response_otp_resend.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';
import '../../utilities/print_util.dart';
import '../../utilities/toast_utils.dart';

class OTPScreen extends StatefulHookConsumerWidget {
  const OTPScreen({required this.responseLogin, Key? key}) : super(key: key);

  final ResponseLogin responseLogin;

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final _focusNode = FocusNode();

  final _otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  late final _auth = ref.watch(authProvider);
  ThemeProvider? _theme;

  ResponseOtpResend? _responseOtpResend;

  var _timerRunCount = -1;
  var _timeLeft = 0;
  final _otpLength = 4;

  int get _timerDefaultValue => _responseOtpResend?.resendTime ?? 60;

  int get _timerMaxRunCount => _responseOtpResend?.maximumRetry ?? 3;

  bool get isTimerRunning => _timer != null && _timer!.isActive;

  bool get isTimerRunCountLimitReached => _timerRunCount == _timerMaxRunCount;

  bool get isOtpValid => _otpController.text.trim().length == _otpLength;

  String get readableTimeLeft {
    final minutes = _timeLeft ~/ 60;
    final seconds = _timeLeft % 60;
    return '$minutes:$seconds';
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _otpController.dispose();
    _focusNode.dispose();
  }

  void _startTimer() {
    ++_timerRunCount;
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _timeLeft = _timerDefaultValue - timer.tick;
        if (_timeLeft == 0) {
          timer.cancel();
        }
        refresh;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _theme = ref.watch(themeProvider);
    
    return Scaffold(
      body: _bodyPartUI(),
    );
  }

  Widget _bodyPartUI() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Margin.vertical40,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title,
                  Margin.vertical8,
                  _subTitle,
                  Margin.vertical16,
                  otpTextField,
                  Margin.vertical16,
                  timerWidget,
                  Margin.vertical8,
                  _resendOTPButton,
                  //_tempThemeChange,
                ],
              ),
            ),
          ),
          Margin.vertical16,
          Expanded(
            flex: 0,
            child: _bottomButton(),
          ),
        ],
      ),
    );
  }

  Widget get _title {
    return Text(
      AppLocalizations.of(context)!.enterCodeSendToYourPhone,
      style: _theme?.ts.extTs36.weightBold,
    );
  }

  Widget get _subTitle {
    return Text(
      '${AppLocalizations.of(context)!.weSentItToNumber} ${widget.responseLogin.mobileNumber} ',
      style: _theme?.ts.extTs16.colorMediumGrey.weightMedium,
    );
  }

  Widget get timerWidget {
    if (isTimerRunCountLimitReached) {
      return Text(AppLocalizations.of(context)!.limitReachedForOtp);
    } else {
      if (isTimerRunning) {
        return Text(
          '${AppLocalizations.of(context)!.resendCodeIn} $readableTimeLeft',
          style: _theme?.ts.extTs14.colorMediumGrey.weightRegular,
        );
      } else {
        return Container();
      }
    }
  }

  Widget get _resendOTPButton {
    if (isTimerRunCountLimitReached || isTimerRunning) {
      return const SizedBox();
    }
    return InkWell(
      onTap: isTimerRunning
          ? null
          : () async {
        _startTimer();
        await _auth.resendOtp(mobile: widget.responseLogin.mobileNumber);
        //_responseOtpResend = await _auth.resendOtp(mobile: widget.responseLogin.mobileNumber);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 40.0,
        width: 100.0,
        child: Text(
          AppLocalizations.of(context)!.resendCode,
          style: isTimerRunning ? _theme?.ts.extTs14.colorMediumGrey.weightMedium600 : _theme?.ts.extTs14.colorTsThemePrimary.weightMedium600,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget get otpTextField {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: PinCodeTextField(
        appContext: context,
        focusNode: _focusNode,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 4,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        cursorHeight: 30.0,
        textStyle: _theme?.ts.extTs36.colorTsThemeBlack.weightRegular,
        pinTheme: PinTheme(
          activeColor: AppColor.lightGrey,
          inactiveColor: AppColor.lightGrey,
          selectedColor: AppColor.lightGrey,
          shape: PinCodeFieldShape.underline,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 80,
          activeFillColor: Colors.transparent,
        ),
        //cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        // errorAnimationController: errorController,
        controller: _otpController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          PrintUtils.instance.printLog('Completed');
          _verifyOtp();
        },
        onChanged: (value) {
          PrintUtils.instance.printLog(value);
          refresh;
        },
      ),
    );
  }

  Widget _bottomButton() {
    return ButtonWidget(
      title: AppLocalizations.of(context)!.verify,
      onPressed: _verifyOtp,
      isDisabled: isOtpValid,
    );
  }

  Future<void> _verifyOtp() async {
    if (!isOtpValid) {
      return;
    }

    final userResponse = await _auth.verifyOtp(
      otp: _otpController.text,
      mobile: widget.responseLogin.mobileNumber,
    );

    if (userResponse?.user != null) {
      AppUtils.instance.configApp(context: context);
      await NavigationUtils.instance.checkAppStateAndProceedFurther(this, auth: _auth);
    } else {
      ToastUtils.instance.showToastRelease(message: 'Invalid OTP');
    }
  }
}
