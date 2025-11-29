import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/navigation/navigation_utils.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../common_widgets/button_widget.dart';
import '../../constants/margin.dart';
import '../../enums/app_enums.dart';
import '../../extensions/state_extensions.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';
import '../../utilities/print_util.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with WidgetsBindingObserver {
  final _focusNode = FocusNode();

  final _numberController = TextEditingController(text: '1000000001');

  bool get isNumberValid {
    return _numberController.text.length == 10;
  }

  late AuthenticationProvider _authProvider;
  late ThemeProvider _theme;

  late LoginState _loginState;

  String get phoneNumber => _numberController.text;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _addObserver();
    });
  }

  bool _isAppStateObserverActive = false;
  void _addObserver() {
    _isAppStateObserverActive = true;
    ref.read(authenticationProvider).addListener(_onProviderChange);
  }

  void _removeObserver() {
    _isAppStateObserverActive = false;
    ref.read(authenticationProvider).removeListener(_onProviderChange);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    PrintUtils.instance.printLog('Login Screen - AppLifecycleState: $state');
    if (state == AppLifecycleState.resumed) {
      _addObserver();
    } else {
      _removeObserver();
    }
  }

  @override
  void dispose() {
    _removeObserver();
    WidgetsBinding.instance.removeObserver(this);
    _numberController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onProviderChange() {
    if (!_isAppStateObserverActive) {
      return;
    }
    _loginState = _authProvider.loginState;

    switch (_loginState) {
      case LoginState.initial:
      case LoginState.loading:
        break;
      case LoginState.success:
        PrintUtils.instance.printWarning('MANDARA -> Login Success....');
        NavigationUtils.instance.checkAppStateAndProceedFurther(this, auth: _authProvider);
        break;
      case LoginState.failure:
        break;
      case LoginState.codeSent:
        PrintUtils.instance.printWarning('MANDARA -> Code Sent....');
        NavigationUtils.instance.moveToOTPScreen(context, phoneNumber: phoneNumber);
        break;
      case LoginState.timeout:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = ref.watch(authenticationProvider);
    _theme = ref.watch(themeProvider);

    _loginState = _authProvider.loginState;

    return Scaffold(
      appBar: const AppBarWidget(title: ''),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_screenTitle(), Margin.vertical8, _subTitle(), Margin.vertical16, _numberTextField()],
            ),
          ),
          Margin.vertical16,
          dummyNumbers,
          Margin.vertical16,
          Expanded(flex: 0, child: _bottomButton()),
        ],
      ),
    );
  }

  Widget _screenTitle() {
    return Text(AppLocalizations.of(context)!.enteryourmobilenumber, style: _theme.ts.extTs36.weightBold);
  }

  Widget _subTitle() {
    return Text(AppLocalizations.of(context)!.wewillsendyouconfirmationcode, style: _theme.ts.extTs16.colorMediumGrey.weightRegular);
  }

  Widget get dummyNumbers {
    return Text('You can user original or Dummy numbers \n\n1000000001, 1000000002, 1000000003, 1000000004, 1000000005, 1000000006, 1000000007, 1000000008, 1000000009\n\nOTP: 123456', style: _theme.ts.extTs16.colorMediumGrey.weightRegular);
  }

  Widget _numberTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 0, child: Text(AppLocalizations.of(context)!.countryCode, style: _theme.ts.extTs36.colorMediumGrey.weightRegular)),
        Margin.horizontal8,
        Expanded(
          child: TextField(
            controller: _numberController,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            maxLength: 10,
            inputFormatters: phoneNumberFormatter(),
            style: _theme.ts.extTs36.colorTsThemeBlack.weightRegular,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
            ),
            onChanged: (text) {
              refresh;
            },
          ),
        ),
      ],
    );
  }

  List<FilteringTextInputFormatter> phoneNumberFormatter() {
    // add code to no space or special character allowed
    return [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
  }

  Widget _bottomButton() {
    //return AnimatedShrinkButton(
    return ButtonWidget(
      title: AppLocalizations.of(context)!.next,
      onPressed: !isNumberValid
          ? null
          : _loginState == LoginState.loading
          ? null
          : _eventLogin,
    );
  }

  Future<void> _eventLogin() async => _authProvider.login(phone: phoneNumber);
}
