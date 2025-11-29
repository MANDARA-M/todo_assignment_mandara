import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/Screens/todo/todo_list_screen.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../common_widgets/tabs/tabs_application.dart';
import '../../extensions/state_extensions.dart';
import '../../l10n/app_localizations.dart';
import '../model/tab_meta_data.dart';

class AppHomeScreen extends StatefulHookConsumerWidget {
  const AppHomeScreen({super.key});

  @override
  ConsumerState<AppHomeScreen> createState() => AppHomeScreenState();
}

class AppHomeScreenState extends ConsumerState<AppHomeScreen> with AutomaticKeepAliveClientMixin<AppHomeScreen> {
  @override
  bool get wantKeepAlive => true;

  late final _localizations = AppLocalizations.of(context)!;

  final homeTabMetaData = <HomeTabsMetaData>[];

  List<TabMetaData> get tabMetaData => homeTabMetaData.map((e) => e.child).toList();

  var currentActiveIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateTabs();
    });
  }

  void _populateTabs() {
    final _keyTodoOwn = GlobalKey<TodoListScreenState>();
    final _keyTodoJoined = GlobalKey<TodoListScreenState>();

    final _homeScreen = TodoListScreen(todoScreenType: .created, key: _keyTodoOwn);
    final _friendsScreen = TodoListScreen(todoScreenType: .joined, key: _keyTodoJoined);

    final _todoOwnTab = HomeTabsMetaData(
      key: _keyTodoOwn,
      child: TabMetaData(title: _localizations.created, child: _homeScreen),
    );
    final _todoJoinedTab = HomeTabsMetaData(
      key: _keyTodoJoined,
      child: TabMetaData(title: _localizations.joined, child: _friendsScreen),
    );

    homeTabMetaData.addAll([_todoOwnTab, _todoJoinedTab]);

    refresh;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (homeTabMetaData.isEmpty) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: const AppBarWidget(title: 'Tasks', isDashboard: true),
      body: TabsApplication(
        tabMetaData: tabMetaData,
        isTabScrollable: false,
        onTap: (index) {
          currentActiveIndex = index;
        },
      ),
    );
  }

  void scrollToTop() {
    homeTabMetaData[currentActiveIndex].key.currentState?.scrollToTop();
  }
}

class HomeTabsMetaData {
  HomeTabsMetaData({required this.key, required this.child});

  GlobalKey<TodoListScreenState> key;
  TabMetaData child;
}
