import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/app_color.dart';
import '../../extensions/state_extensions.dart';
import '../../gen/assets.gen.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/navigation_utils.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';
import '../../wrapper/base_widget_wrapper.dart';
import '../bottom_sheets/bottomsheet_todo_event_options.dart';
import '../common/create_floating_button.dart';
import 'app_home_screen.dart';
import 'demo_home_screen.dart';

class DashboardScreen extends StatefulHookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late final _localizations = AppLocalizations.of(context)!;

  AuthenticationProvider? _authProvider;
  ThemeProvider? _theme;

  final ScrollController _scrollController = ScrollController();

  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];
  final _homeNavigationScreens = <Widget>[];
  final _navigatorKeys = <GlobalKey<NavigatorState>>[];

  static const int homeIndex = 0;
  int _currentIndex = homeIndex;

  final List<int> _tabHistory = <int>[];

  late final pageController = PageController(initialPage: _currentIndex);

  final _keyHome = GlobalKey<AppHomeScreenState>();

  bool _isDataInitialized = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void initData() {
    if (!_isDataInitialized) {
      _isDataInitialized = true;
      _refreshTabs();
      refresh;
    }
  }

  void _refreshTabs() {
    _bottomNavigationBarItems.clear();
    _bottomNavigationBarItems.addAll([
      _bottomNavigationBarItem(label: _localizations.home, iconData: FluentIcons.home_12_regular, iconDataActive: FluentIcons.home_12_filled),
      _bottomNavigationBarItem(label: _localizations.search, iconData: FluentIcons.search_12_regular, iconDataActive: FluentIcons.search_12_filled),
      BottomNavigationBarItem(
        label: _localizations.create,
        icon: CreateFloatingButton(size: 24, backgroundColor: AppColor.themeColorPrimaryCommon),
      ),
      _bottomNavigationBarItem(label: _localizations.chart, iconData: FontAwesomeIcons.chartSimple, iconDataActive: FontAwesomeIcons.chartSimple),
      BottomNavigationBarItem(label: _localizations.profile, icon: _profileWidget),
    ]);

    _homeNavigationScreens.clear();
    _homeNavigationScreens.addAll([AppHomeScreen(key: _keyHome), const DemoHomeScreen(), Container(), const DemoHomeScreen(), Container()]);

    _navigatorKeys.clear();
    _navigatorKeys.addAll(List.generate(_bottomNavigationBarItems.length, (_) => GlobalKey<NavigatorState>()));
  }

  Widget get _profileWidget {
    return Container(constraints: BoxConstraints.tight(const Size.square(22.0)), child: Assets.images.profile.profileIcon.image());
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = ref.watch(authenticationProvider);
    _theme = ref.watch(themeProvider);

    initData();

    return PopScope(canPop: canPop, onPopInvokedWithResult: onPopInvokedWithResult, child: _mainWidget);
  }

  Widget get _mainWidget {
    return Scaffold(
      body: BaseWidgetWrapper(child: _mainWidgetScreens),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  //int canPopClickCount = 0;
  //Timer? canPopTimer;

  bool get canPop {
    final currentNav = _navigatorKeys[_currentIndex].currentState;
    final navStateCanPop = currentNav?.canPop() ?? true;
    final canPop = !(navStateCanPop || _tabHistory.isNotEmpty || _currentIndex != homeIndex);

    return canPop;
    /*if (!canPop) {
      return false;
    }

    ++canPopClickCount;

    canPopTimer?.cancel();
    if (canPopClickCount > 1) {
      canPopClickCount = 0;
      return true;
    } else {
      canPopTimer = Timer(const Duration(seconds: 10), () {
        canPopClickCount = 0;
      });
      return false;
    }*/
  }

  Future<void> onPopInvokedWithResult(bool didPop, dynamic result) async {
    if (didPop) {
      return;
    }

    final currentNav = _navigatorKeys[_currentIndex].currentState!;
    if (currentNav.canPop()) {
      currentNav.pop();
      return; // handled
    }
    // If we have prior tabs in history, go back to the last one:
    if (_tabHistory.isNotEmpty) {
      _currentIndex = _tabHistory.removeLast();
      refresh;
      return;
    }

    if (_currentIndex != homeIndex) {
      _currentIndex = homeIndex;
      refresh;
      return; // switch to home instead of exiting
    }
    // finally: let the system close the app
    unawaited(Navigator.of(context).maybePop());
  }

  Widget get _mainWidgetScreens {
    return IndexedStack(
      index: _currentIndex,
      children: List.generate(_bottomNavigationBarItems.length, (index) => _buildTabNavigator(index: index)),
    );
  }

  Widget _buildTabNavigator({required int index}) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        final page = _homeNavigationScreens[index];
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: _theme?.ts.extTs10.colorTsThemeBlack.weightBold,
      unselectedLabelStyle: _theme?.ts.extTs10.colorPrimary.weightMedium,
      unselectedItemColor: _theme?.textColor,
      onTap: (newPage) {
        if (newPage == 2) {
          _showBottomSheetDashboard();
        } else if (newPage == 4) {
          _showUserProfile();
        } else {
          _moveToPage(index: newPage);
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _theme?.getBottomSheetActionColor(true),
      items: _bottomNavigationBarItems,
    );
  }

  void _moveToPage({required int index}) {
    if (index == _currentIndex) {
      if (index == 0) {
        _keyHome.currentState?.scrollToTop();
      }

      _navigatorKeys[index].currentState!.popUntil((r) => r.isFirst);
      return;
    }

    _tabHistory.remove(index);
    _tabHistory.add(_currentIndex);

    _currentIndex = index;
    refresh;
  }

  void _showBottomSheetDashboard() {
    _authProvider?.observerLogin(
      context,
      loginSuccess: (session) {
        BottomSheetTodoEventOptions.show(context);
      },
    );
  }

  void _showUserProfile() {
    _authProvider?.observerLogin(
      context,
      loginSuccess: (session) {
        NavigationUtils.instance.moveToProfileScreen(context: context);
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData iconData,
    required IconData iconDataActive,
    String? label,
    double? unselectedIconSize = 18,
    double? activeIconSize = 18,
  }) {
    final title = label ?? '';
    return BottomNavigationBarItem(
      tooltip: title,
      icon: Icon(iconData, color: _theme?.getBottomSheetActionColor(false), size: unselectedIconSize),
      activeIcon: Icon(iconDataActive, color: _theme?.getBottomSheetActionColor(true), size: activeIconSize),
      label: title,
    );
  }
}
