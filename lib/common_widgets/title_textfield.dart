import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/app_color.dart';
import '../l10n/app_localizations.dart';
import '../notifiers/validation_notifier.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';
import 'error_indicator_widget.dart';

class TitleTextField extends StatefulHookConsumerWidget {
  const TitleTextField({
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixTap,
    this.onSuffixTap,
    this.controller,
    this.decoration,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.formValidate = false,
    this.inputFormatters,
    this.keyboardType,
    this.obscureText = false,
    this.titleTextStyle,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines = 1,
    this.autofillHints,
    this.focusNode,
    this.shouldValidate,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.enabled = true,
    this.showErrorIcon = true,
    this.isNoBorder = false,
    Key? key,
  })  : assert(onPrefixTap == null || prefixIcon != null),
        super(key: key);

  final String title;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onPrefixTap;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String)? validator;
  final bool formValidate;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? titleTextStyle;
  final TextAlign textAlign;
  final int? maxLength;
  final int? maxLines;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final ValidationNotifier? shouldValidate;
  final TextCapitalization textCapitalization;
  final bool readOnly;
  final bool enabled;
  final bool showErrorIcon;
  final bool isNoBorder;

  @override
  ConsumerState<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends ConsumerState<TitleTextField> {
  String? error;
  late final controller = widget.controller ?? TextEditingController();
  late final _theme = ref.watch<ThemeProvider>(themeProvider);
  late final _localizations = AppLocalizations.of(context)!;

  late final FocusNode _focusNode = (widget.focusNode ?? FocusNode())
    ..addListener(() async {
      if (!_focusNode.hasFocus) {
        error = widget.validator?.call(controller.text);
        setState(() {});
      }
    });

  final radius = 8.0;
  late final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(
      color: _theme.textFieldBorderColor ?? Colors.transparent,
      width: 0.5,
    ),
  );

  late final _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: const BorderSide(color: AppColor.errorRed),
  );

  bool get isNoBorder => widget.isNoBorder;

  OutlineInputBorder get _noBorder => const OutlineInputBorder(
        borderSide: BorderSide.none,
      );

  bool get isError => error != null && error!.isNotEmpty;

  OutlineInputBorder get border => isNoBorder ? _noBorder : _border;

  OutlineInputBorder get inputBorder => isError ? border : _errorBorder;

  bool get isValid => widget.shouldValidate?.isValid ?? true;

  @override
  void initState() {
    super.initState();
    widget.shouldValidate?.addListener(() async {
      _validateAndCheckError();
    });
  }

  void _validateAndCheckError() {
    if (widget.shouldValidate?.shouldValidate ?? false) {
      error = null;
      widget.shouldValidate?.isValid = true;

      final text = controller.text;
      if (text.isEmpty) {
        error = _localizations.errorEmptyInput;
      } else {
        error = widget.validator?.call(text);
      }

      if (error != null && error!.isNotEmpty) {
        widget.shouldValidate?.isValid = false;
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = isNoBorder ? _noBorder : null;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: widget.maxLines ?? 1,
                style: _theme.ts.extTs12,
                enabled: widget.enabled,
                decoration: widget.decoration?.copyWith(
                      border: border,
                    ) ??
                    _theme.inputDecorationMain(isError: isError).copyWith(
                          border: border,
                          enabledBorder: border,
                          focusedBorder: border,
                          errorBorder: border,
                          disabledBorder: border,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8, top: 16, left: 8),
                            child: widget.suffixIcon,
                          ),
                          labelText: widget.title,
                          labelStyle: widget.titleTextStyle ?? _theme.ts.extTs14,
                          prefixIcon: widget.prefixIcon == null
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: InkWell(
                                    onTap: widget.onPrefixTap,
                                    child: Icon(widget.prefixIcon, color: _theme.iconColor),
                                  ),
                                ),
                        ),
                autocorrect: false,
                controller: controller,
                validator: (value) {
                  if (widget.formValidate) {
                    _validateAndCheckError();
                    return isValid ? null : error;
                  }

                  widget.shouldValidate?.isValid = true;
                  return null;
                },
                onChanged: (text) async {
                  _validateAndCheckError();
                  widget.onChanged?.call(text);
                },
                textAlign: widget.textAlign,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText,
                maxLength: widget.maxLength,
                autofillHints: widget.autofillHints,
                focusNode: _focusNode,
                textCapitalization: widget.textCapitalization,
                onEditingComplete: () {
                  _focusNode.unfocus();
                },
                onFieldSubmitted: (value) {
                  _validateAndCheckError();
                  widget.onChanged?.call(value);
                  _focusNode.unfocus();
                },
              ),
            ),
          ],
        ),
        ErrorIndicatorWidget(
          error: error,
          showErrorIcon: widget.showErrorIcon,
        ),
      ],
    );
  }
}
