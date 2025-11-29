import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/navigation/navigation_utils.dart';

import '../../common_widgets/bottom_sheet/bottom_sheet.dart';
import '../../enums/app_enums.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import 'bottom_sheet_model/bottom_options.dart';
import 'bottom_sheet_widgets/bottom_options_ui.dart';
import 'bottomsheet_task_add.dart';

class BottomSheetTodoEventOptions extends StatefulHookConsumerWidget {
  const BottomSheetTodoEventOptions({required this.scrollController, required this.parentContext, super.key});

  final ScrollController scrollController;
  final BuildContext parentContext;

  static Future<void> show(BuildContext parentContext) async {
    return parentContext.showModalBottomSheetWidget<void>(
      bottomSheetChildBuilder: (context, scrollController) => BottomSheetTodoEventOptions(scrollController: scrollController, parentContext: parentContext),
    );
  }

  @override
  ConsumerState<BottomSheetTodoEventOptions> createState() => _BottomSheetTodoEventOptionsState();
}

class _BottomSheetTodoEventOptionsState extends ConsumerState<BottomSheetTodoEventOptions> {
  late final _localizations = AppLocalizations.of(context)!;
  late ThemeProvider theme = ref.watch(themeProvider);

  late final options = <BottomOptions<TodoEventOptions>>[
    BottomOptions(
      id: TodoEventOptions.AddTodo,
      title: _localizations.createNewTask,
      icon: FontAwesomeIcons.circlePlus,
      onTap: () {
        NavigationUtils.instance.moveToCreateTaskScreen(context: context);
      },
    ),
    BottomOptions(
      id: TodoEventOptions.GetSharedTodo,
      title: _localizations.joinTask,
      icon: FontAwesomeIcons.diagramSuccessor,
      onTap: () {
        BottomSheetTaskAdd.show(context);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomOptionsUI(uiType: BottomSheetEventOptionsUI.listTile, options: options);
  }
}

enum TodoEventOptions { GetSharedTodo, AddTodo }
