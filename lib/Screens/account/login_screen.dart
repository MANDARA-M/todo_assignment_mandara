import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../common_widgets/button_widget.dart';
import '../../constants/margin.dart';
import '../../extensions/state_extensions.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/navigation_utils.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _focusNode = FocusNode();

  final _numberController = TextEditingController();

  bool get isNumberValid {
    return _numberController.text.length == 10;
  }

  late AuthProvider _auth;
  late ThemeProvider _theme;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _numberController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = ref.watch(authProvider);
    _theme = ref.watch(themeProvider);

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
              children: [
                _screenTitle(),
                Margin.vertical8,
                _subTitle(),
                Margin.vertical16,
                _numberTextField(),
              ],
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

  Widget _screenTitle() {
    return Text(
      AppLocalizations.of(context)!.enteryourmobilenumber,
      style: _theme.ts.extTs36.weightBold,
    );
  }

  Widget _subTitle() {
    return Text(
      AppLocalizations.of(context)!.wewillsendyouconfirmationcode,
      style: _theme.ts.extTs16.colorMediumGrey.weightRegular,
    );
  }

  Widget _numberTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 0,
          child: Text(
            AppLocalizations.of(context)!.countryCode,
            style: _theme.ts.extTs36.colorMediumGrey.weightRegular,
          ),
        ),
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
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
  }

  Widget _bottomButton() {
    //return AnimatedShrinkButton(
    return ButtonWidget(
      title: AppLocalizations.of(context)!.next,
      onPressed: !isNumberValid ? null : () async {
        final response = await _auth.login(_numberController.text);
        if (response != null && mounted) {
          NavigationUtils.instance.moveToOTPScreen(context, response);
        }
      },
    );
  }
}
