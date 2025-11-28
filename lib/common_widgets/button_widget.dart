import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/app_color.dart';
import '../constants/margin.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';

class ButtonWidget extends StatefulHookConsumerWidget {
  const ButtonWidget({
    required this.title,
    this.height,
    this.width = double.infinity,
    this.type = ButtonType.theme,
    this.iconPath,
    this.trailingIconPath,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.isDisabled = false,
    this.alignment,
    this.avoidOnPressLock = false,
    this.coloredImage = true,
    this.textColor,
    //this.buttonColor,
    //this.borderRadius,
    Key? key,
  }) : assert(type != ButtonType.textTertiaryWithSuffix || prefixIcon != null && suffixIcon != null),
       super(key: key);

  const ButtonWidget.icon({
    required this.iconPath,
    this.title = '',
    this.height,
    this.width = double.infinity,
    this.type = ButtonType.icon,
    this.trailingIconPath,
    this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.isDisabled = false,
    this.alignment,
    this.avoidOnPressLock = false,
    this.coloredImage = true,
    this.textColor,
    //this.buttonColor,
    //this.borderRadius,
    Key? key,
  }) : super(key: key);

  final String title;
  final double? height;
  final double width;
  final ButtonType type;
  final String? iconPath;
  final String? trailingIconPath;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final AlignmentGeometry? alignment;
  final bool avoidOnPressLock;
  final bool coloredImage;
  final Color? textColor;

  //final Color? buttonColor;
  //final BorderRadius? borderRadius;

  @override
  ConsumerState<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends ConsumerState<ButtonWidget> {
  late ThemeProvider theme = ref.watch(themeProvider);

  bool _isPressed = false;

  Future<void> onPressed() async {
    if (!isPressed) {
      isPressed = true;
      if (widget.onPressed is Future<dynamic> Function()) {
        await (widget.onPressed! as Future<dynamic> Function()).call();
      } else {
        widget.onPressed?.call();
      }
      isPressed = false;
    }
  }

  bool get isPressed => _isPressed;

  set isPressed(bool isPressed) {
    if (!widget.avoidOnPressLock) {
      setState(() => _isPressed = isPressed);
    }
  }

  bool get isShowIcon => widget.iconPath != null;

  bool get isShowTrailingIcon => widget.trailingIconPath != null;

  bool get isDisable => widget.isDisabled || widget.onPressed == null || isPressed;

  ButtonStyle? _buttonStyle() {
    ButtonStyle? style;

    switch (widget.type) {
      case ButtonType.theme:
      case ButtonType.icon:
        style = theme.buttonPrimary;
        break;
      case ButtonType.secondaryWithIcon:
        style = theme.buttonSecondary;
        break;
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        style = theme.buttonTextTertiary;
        break;
      case ButtonType.hollow:
        style = theme.buttonHollow;
        break;
      case ButtonType.red:
        style = theme.buttonRed;
        break;
    }

    return style?.copyWith(
      alignment: widget.alignment,
      minimumSize: WidgetStateProperty.all(Size(widthOfButton ?? 0, heightOfButton)),
      fixedSize: WidgetStateProperty.all(Size(widthOfButton ?? double.infinity, heightOfButton)),
      maximumSize: WidgetStateProperty.all(Size.fromHeight(heightOfButton)),
      /*backgroundColor: WidgetStateProperty.all(widget.buttonColor ?? style?.backgroundColor?.resolve({})),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
      )),*/
      textStyle: style.textStyle,
    );
  }

  Color _colorIcon() {
    if (isDisable) {
      return AppColor.themeColorWhite;
    }

    switch (widget.type) {
      case ButtonType.theme:
      case ButtonType.secondaryWithIcon:
        return AppColor.themeColorWhite;
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        return theme.primaryColor;
      case ButtonType.hollow:
        return theme.textColor;
      case ButtonType.icon:
        return AppColor.themeColorWhite;
      case ButtonType.red:
        return AppColor.themeColorWhite;
    }
  }

  double get heightOfButton {
    switch (widget.type) {
      case ButtonType.icon:
        return widget.height ?? 56.0;
      case ButtonType.theme:
      case ButtonType.red:
        return widget.height ?? 56.0;
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        return widget.height ?? 40.0;
      case ButtonType.secondaryWithIcon:
        return widget.height ?? 33.0;
      case ButtonType.hollow:
        return widget.height ?? 56.0;
    }
  }

  double? get widthOfButton {
    switch (widget.type) {
      case ButtonType.theme:
      case ButtonType.red:
      case ButtonType.icon:
      case ButtonType.secondaryWithIcon:
      case ButtonType.hollow:
        return widget.width;
      case ButtonType.textTertiary:
      case ButtonType.textTertiaryWithSuffix:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightOfButton,
      child: Consumer(
        builder: (context, ref, child) {
          switch (widget.type) {
            case ButtonType.theme:
            case ButtonType.red:
              return _getElevatedButton();
            case ButtonType.secondaryWithIcon:
              return _getSecondaryIconButton();
            case ButtonType.textTertiary:
              return _getTertiaryIconButton();
            case ButtonType.textTertiaryWithSuffix:
              return _getTertiaryIconWithSuffixButton();
            case ButtonType.hollow:
              return _getHollowButton();
            case ButtonType.icon:
              return _getIconButton();
          }
        },
      ),
    );
  }

  Widget _getElevatedButton() {
    final style = _buttonStyle();
    return ElevatedButton(
      style: style,
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.prefixIcon != null) ...[Icon(widget.prefixIcon, size: 24, color: _colorIcon()), Margin.horizontal10],
          if (isShowIcon) getImage(iconPath: widget.iconPath!, height: 24, width: 24, theme: theme),
          if (isShowIcon) Margin.horizontal11,
          titleWidget,
        ],
      ),
    );
  }

  Widget _getSecondaryIconButton() {
    final style = _buttonStyle();
    return ElevatedButton(
      style: style,
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(child: titleWidget),
          Margin.horizontal11,
          if (isShowIcon) getImage(iconPath: widget.iconPath!, height: 13, width: 13, theme: theme),
        ],
      ),
    );
  }

  Widget _getTertiaryIconButton() {
    return TextButton(
      style: _buttonStyle(),
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isShowIcon) getImage(height: 24, width: 24, iconPath: widget.iconPath!, theme: theme),
          if (isShowIcon) Margin.horizontal11,
          titleWidget,
          if (isShowTrailingIcon) ...[Margin.horizontal8, getImage(height: 16, width: 16, iconPath: widget.trailingIconPath!, theme: theme)],
        ],
      ),
    );
  }

  Widget _getTertiaryIconWithSuffixButton() {
    return TextButton(
      style: _buttonStyle(),
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(widget.prefixIcon, size: 20), Margin.horizontal10, titleWidget, const Spacer(), Icon(widget.suffixIcon, size: 20)],
      ),
    );
  }

  Widget _getHollowButton() {
    return ElevatedButton(
      style: _buttonStyle(),
      onPressed: isDisable ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isShowIcon) getImage(height: 22, width: 22, iconPath: widget.iconPath!, theme: theme),
          if (isShowIcon) Margin.horizontal16,
          titleWidget,
        ],
      ),
    );
  }

  Widget _getIconButton() {
    return ElevatedButton(
      style: _buttonStyle(),
      onPressed: isDisable ? null : onPressed,
      child: Image(image: AssetImage(widget.iconPath!), height: 22, width: 22, color: _colorIcon(), fit: BoxFit.fill),
    );
  }

  Widget get titleWidget => Text(widget.title, style: theme.ts.extTs14.copyWith(color: widget.textColor));

  Widget getImage({required double height, required double width, required String iconPath, required ThemeProvider theme}) {
    return Image(image: AssetImage(iconPath), height: height, width: width, color: widget.coloredImage ? _colorIcon() : null);
  }
}

enum ButtonType { theme, secondaryWithIcon, textTertiary, textTertiaryWithSuffix, hollow, icon, red }
