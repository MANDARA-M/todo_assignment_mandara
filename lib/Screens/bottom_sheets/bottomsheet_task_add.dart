import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/Screens/todo/todo_card_widget.dart';
import 'package:inSTA/common_widgets/button_widget.dart';
import 'package:inSTA/common_widgets/custom_widget.dart';
import 'package:inSTA/common_widgets/title_textfield.dart';
import 'package:inSTA/constants/margin.dart';
import 'package:inSTA/navigation/navigation_utils.dart';
import 'package:inSTA/utilities/storage/shared_preference/shared_preferences_util.dart';
import 'package:inSTA/utilities/toast_utils.dart';

import '../../common_widgets/bottom_sheet/bottom_sheet.dart';
import '../../extensions/state_extensions.dart';
import '../../firebase/services/data_service.dart';
import '../../l10n/app_localizations.dart';
import '../../network/models/todo/task.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';

class BottomSheetTaskAdd extends StatefulHookConsumerWidget {
  const BottomSheetTaskAdd({required this.scrollController, required this.parentContext, super.key});

  final ScrollController scrollController;
  final BuildContext parentContext;

  static Future<void> show(BuildContext parentContext, {OnEmojiSelected? onEmojiSelected}) async {
    return parentContext.showModalBottomSheetWidget<void>(
      bottomSheetChildBuilder: (context, scrollController) => BottomSheetTaskAdd(scrollController: scrollController, parentContext: parentContext),
    );
  }

  @override
  ConsumerState<BottomSheetTaskAdd> createState() => _BottomSheetTaskAddState();
}

class _BottomSheetTaskAddState extends ConsumerState<BottomSheetTaskAdd> {
  late final _localizations = AppLocalizations.of(context)!;

  late ThemeProvider theme = ref.watch(themeProvider);

  final _dataService = DataService.instance;

  final taskIdController = TextEditingController();

  String get docId => taskIdController.text.trim();

  Task? task;
  bool isAddAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomWidget.instance.getLinksBottomSheetTopUI(theme: theme, title: _localizations.addTaskTitle, description: _localizations.addTaskDescription),
          Margin.vertical24,
          if (!isAddAvailable) TitleTextField(title: 'Task Id', prefixIcon: Icons.task_alt, controller: taskIdController),
          if (task != null) ...[Margin.vertical24, ToDoCardWidget(docId: docId, task: task!, isActive: false,)],
          Margin.vertical32,
          if (!isAddAvailable) _buttonFetch,
          if (isAddAvailable) _buttonJoin,
        ],
      ),
    );
  }

  Widget get _buttonFetch {
    return ButtonWidget(
      title: _localizations.fetchTask,
      onPressed: () async {
        final task = await _dataService.getTaskById(docId);
        this.task = task;
        refresh;

        if (task == null) {
          _showToast(_localizations.toastErrorNoTaskFound);
        } else if (task.isOwner) {
          _showToast(_localizations.toastErrorTaskOwner);
        } else if (task.isJoined) {
          _showToast(_localizations.toastErrorTaskAlreadyJoined);
        } else {
          isAddAvailable = true;
          refresh;
        }
      },
    );
  }

  Widget get _buttonJoin {
    return ButtonWidget(
      title: _localizations.joinTask,
      onPressed: () async {
        if (task != null) {
          final userId = SharedPreferencesUtil.instance.userId;

          task!.sharedWith.remove(userId);
          task!.sharedWith.add(userId);

          _dataService.updateTask(docId: docId, task: task!);
          _showToast(_localizations.toastSuccessJoined);
          NavigationUtils.instance.pop(context: context);
        }
      },
    );
  }

  void _showToast(String message) {
    ToastUtils.instance.showToastRelease(message: message);
  }
}
