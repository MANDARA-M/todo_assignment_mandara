import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/utilities/app_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common_widgets/button_widget.dart';
import '../../constants/app_color.dart';
import '../../constants/margin.dart';
import '../../enums/app_enums.dart';
import '../../extensions/state_extensions.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';
import '../../utilities/print_util.dart';
import '../../utilities/toast_utils.dart';

class OTPScreen extends StatefulHookConsumerWidget {
  const OTPScreen({required this.phoneNumber, Key? key}) : super(key: key);

  final String phoneNumber;

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final _focusNode = FocusNode();

  final _otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  late AuthProvider _authProvider;
  late ThemeProvider _theme;

  late OtpVerificationState _otpVerificationState;

  var _timerRunCount = -1;
  var _timeLeft = 0;
  final _otpLength = 6;
  final _timerDefaultValue = 60;
  final _timerMaxRunCount = 3;

  bool get isTimerRunning => _timer != null && _timer!.isActive;

  bool get isTimerRunCountLimitReached => _timerRunCount == _timerMaxRunCount;

  bool get isOtpValid => _otpController.text.trim().length == _otpLength;

  String get readableTimeLeft {
    final minutes = _timeLeft ~/ 60;
    final seconds = _timeLeft % 60;
    return '$minutes:$seconds';
  }

  Timer? _timer;

  String get phoneNumber => widget.phoneNumber;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      final provider = ref.read(authProvider);
      provider.addListener(_onProviderChange);
    });
  }

  @override
  void dispose() {
    super.dispose();

    ref.read(authProvider).removeListener(_onProviderChange);
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _otpController.dispose();
    _focusNode.dispose();
  }

  void _onProviderChange() {
    _otpVerificationState = _authProvider.otpVerificationState;

    switch (_otpVerificationState) {
      case OtpVerificationState.initial:
      case OtpVerificationState.loading:
        break;
      case OtpVerificationState.success:
        AppUtils.instance.configApp(context: context);
        break;
      case OtpVerificationState.failure:
        ToastUtils.instance.showToastRelease(message: 'Invalid OTP');
        break;
    }
  }

  void _startTimer() {
    ++_timerRunCount;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeLeft = _timerDefaultValue - timer.tick;
      if (_timeLeft == 0) {
        timer.cancel();
      }
      refresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = ref.watch(authProvider);
    _theme = ref.watch(themeProvider);

    _otpVerificationState = _authProvider.otpVerificationState;

    return Scaffold(body: _bodyPartUI());
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
          Expanded(flex: 0, child: _bottomButton()),
        ],
      ),
    );
  }

  Widget get _title {
    return Text(AppLocalizations.of(context)!.enterCodeSendToYourPhone, style: _theme.ts.extTs36.weightBold);
  }

  Widget get _subTitle {
    return Text(
      '${AppLocalizations.of(context)!.weSentItToNumber} $phoneNumber',
      style: _theme.ts.extTs16.colorMediumGrey.weightMedium,
    );
  }

  Widget get timerWidget {
    if (isTimerRunCountLimitReached) {
      return Text(AppLocalizations.of(context)!.limitReachedForOtp);
    } else {
      if (isTimerRunning) {
        return Text('${AppLocalizations.of(context)!.resendCodeIn} $readableTimeLeft', style: _theme.ts.extTs14.colorMediumGrey.weightRegular);
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
              await _authProvider.resendOtp(mobile: phoneNumber);
            },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 40.0,
        width: 100.0,
        child: Text(
          AppLocalizations.of(context)!.resendCode,
          style: isTimerRunning ? _theme.ts.extTs14.colorMediumGrey.weightMedium600 : _theme.ts.extTs14.colorTsThemePrimary.weightMedium600,
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
        pastedTextStyle: TextStyle(color: Colors.green.shade600, fontWeight: FontWeight.bold),
        length: _otpLength,
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        cursorHeight: 30.0,
        textStyle: _theme.ts.extTs32.colorTsThemeBlack.weightRegular,
        pinTheme: PinTheme(
          activeColor: AppColor.lightGrey,
          inactiveColor: AppColor.lightGrey,
          selectedColor: AppColor.lightGrey,
          shape: PinCodeFieldShape.underline,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 45,
          fieldWidth: 45,
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
    return ButtonWidget(title: AppLocalizations.of(context)!.verify, onPressed: _verifyOtp, isDisabled: isOtpValid);
  }

  Future<void> _verifyOtp() async {
    if (!isOtpValid) {
      return;
    }

    await _authProvider.verifyOtp(otp: _otpController.text);
  }
}
