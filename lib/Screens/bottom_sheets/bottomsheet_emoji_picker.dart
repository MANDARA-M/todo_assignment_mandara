import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/bottom_sheet/bottom_sheet.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';

class BottomSheetEmojiPicker extends StatefulHookConsumerWidget {
  const BottomSheetEmojiPicker({
    required this.scrollController,
    required this.parentContext,
    this.onEmojiSelected,
    super.key,
  });

  final ScrollController scrollController;
  final BuildContext parentContext;
  final OnEmojiSelected? onEmojiSelected;

  static Future<void> show(BuildContext parentContext, {OnEmojiSelected? onEmojiSelected}) async {
    return parentContext.showModalBottomSheetWidget<void>(
      isScrollControlled: true,
      maxSize: 0,
      bottomSheetChildBuilder: (context, scrollController) => BottomSheetEmojiPicker(
        scrollController: scrollController,
        parentContext: parentContext,
        onEmojiSelected: onEmojiSelected,
      ),
    );
  }

  @override
  ConsumerState<BottomSheetEmojiPicker> createState() => _BottomSheetEmojiPickerState();
}

class _BottomSheetEmojiPickerState extends ConsumerState<BottomSheetEmojiPicker> {
  late ThemeProvider theme = ref.watch(themeProvider);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              widget.onEmojiSelected?.call(category, emoji);
              Timer(const Duration(milliseconds: 100), () {
                Navigator.of(context).pop();
              });
            },
            config: Config(
              emojiViewConfig: EmojiViewConfig(
                columns: 7,
                emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                backgroundColor: theme.cardColor ?? Colors.white,
              ),
            ),
          ),
        ));
  }
}
