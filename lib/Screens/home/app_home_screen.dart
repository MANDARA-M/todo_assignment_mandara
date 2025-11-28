import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../common_widgets/tabs/tabs_application.dart';
import '../../enums/app_enums.dart';
import '../../extensions/state_extensions.dart';
import '../../l10n/app_localizations.dart';
import '../feed/feed_list_main_screen.dart';
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
    final _keyHome = GlobalKey<FeedListScreenState>();
    final _keyFriends = GlobalKey<FeedListScreenState>();
    final _keyTrending = GlobalKey<FeedListScreenState>();
    final _keyCommunity = GlobalKey<FeedListScreenState>();

    final _homeScreen = FeedListScreen.create(
      feedType: .feedAppHome,
      //feedType: .feedAppCommunity,
      isFollowButtonVisible: true,
      isMoreButtonVisible: true,
      key: _keyHome,
    );
    final _friendsScreen = FeedListScreen.create(
      feedType: .feedAppFriends,
      isFollowButtonVisible: true,
      isMoreButtonVisible: true,
      key: _keyFriends,
    );
    final _trendingScreen = FeedListScreen.create(
      feedType: .feedAppTrending,
      isFollowButtonVisible: true,
      isMoreButtonVisible: true,
      key: _keyTrending,
    );
    final _communityScreen = FeedListScreen.create(
      feedType: FeedType.feedAppCommunity,
      key: _keyCommunity,
    );

    final _homeScreenTab = HomeTabsMetaData(key: _keyHome, child: TabMetaData(title: _localizations.tabForYou, child: _homeScreen));
    final _friendsScreenTab = HomeTabsMetaData(key: _keyFriends, child: TabMetaData(title: _localizations.tabFriends, child: _friendsScreen));
    final _trendingScreenTab = HomeTabsMetaData(key: _keyTrending, child: TabMetaData(title: _localizations.tabTrending, child: _trendingScreen));
    final _communityScreenTab = HomeTabsMetaData(key: _keyCommunity, child: TabMetaData(title: _localizations.tabCommunity, child: _communityScreen));

    homeTabMetaData.addAll([_homeScreenTab, _friendsScreenTab, _trendingScreenTab, _communityScreenTab]);

    refresh;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (homeTabMetaData.isEmpty) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: const AppBarWidget(
        title: '',
        isDashboard: true,
        isSearchActionVisible: true,
      ),
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

  GlobalKey<FeedListScreenState> key;
  TabMetaData child;
}
