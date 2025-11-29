import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Screens/model/tab_meta_data.dart';
import '../../constants/app_color.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../Tabs/dynamic_sliver_appbar.dart';

class TabsApplication extends StatefulHookConsumerWidget {
  const TabsApplication({
    required this.tabMetaData,
    this.overrideAppBar,
    this.isTabScrollable = true,
    this.padding = 16.0,
    this.scrollController,
    this.isChildTab = false,
    this.isSnap = false,
    this.onTap,
    super.key,
  });

  final List<TabMetaData> tabMetaData;
  final DynamicSliverAppBar? overrideAppBar;
  final double padding;
  final bool isTabScrollable;
  final ScrollController? scrollController;
  final bool isChildTab;
  final bool isSnap;
  final ValueChanged<int>? onTap;

  @override
  ConsumerState<TabsApplication> createState() => _TabsApplicationState();
}

class _TabsApplicationState extends ConsumerState<TabsApplication> with SingleTickerProviderStateMixin {
  ThemeProvider get theme => ref.watch(themeProvider);

  ValueChanged<int>? get onTap => widget.onTap;
  List<TabMetaData> get tabMetaData => widget.tabMetaData;

  DynamicSliverAppBar? get overrideAppBar => widget.overrideAppBar;

  double get maxHeight => overrideAppBar?.maxHeight ?? maxDefaultHeight;

  double get maxDefaultHeight => 48;

  bool get isScrollable => widget.isTabScrollable;

  bool get isChildTab => widget.isChildTab;

  late TabController _tabController;

  // Scroll controller for the NestedScrollView itself (outer scroll)
  final ScrollController _localNestedScrollController = ScrollController();

  ScrollController get _primaryNestedScrollController => widget.scrollController ?? _localNestedScrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabMetaData.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _primaryNestedScrollController.jumpTo(1);
      _primaryNestedScrollController.jumpTo(0);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    if (widget.scrollController == null) {
      _localNestedScrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabMetaData.length,
      child: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        //physics: const ClampingScrollPhysics(),
        controller: _primaryNestedScrollController,
        headerSliverBuilder: (context, value) {
          return [
            /*SliverAppBar(
              title: const Text('Dynamic Header (Simple)'),
              pinned: true,
              floating: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: const Text(
                    'Scroll Me!',
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: tabMetaData.map((tab) => Tab(text: tab.title)).toList(),
              ),
            ),
*/
            DynamicSliverAppBar(
              snap: widget.isSnap,
              maxHeight: maxHeight,
              bottom: TabBarBottomWidget(
                theme: theme,
                child: sliverBottom,
              ),
              //bottom: sliverBottom,
              child: overrideAppBar?.child ?? const SizedBox.shrink(),
            ),
          ];
        },
        body: isChildTab
            ? _tabsChildren
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: _tabsChildren),
                ],
              ),
        /*body: Builder(
          builder: (context) {
            return isChildTab
                ? _tabsChildren
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: _tabsChildren),
                    ],
                  );
          },
        ),*/
      ),
    );
  }

  TabBarView get _tabsChildren {
    return TabBarView(
      controller: _tabController,
      children: tabMetaData.map((e) => e.child).toList(),
    );
  }

  PreferredSizeWidget get sliverBottom {
    final selectedColor = theme.textColor;
    return TabBar(
      onTap: onTap,
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: isScrollable,
      tabAlignment: isScrollable ? TabAlignment.start : null,
      labelColor: selectedColor,
      indicatorColor: selectedColor,
      // only bottom indicator line
      indicator: BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: selectedColor)),
      ),
      tabs: tabMetaData
          .map((e) => Tab(
                  child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(e.title ?? ''),
              )))
          .toList(),
    );
  }
}

class TabBarBottomWidget extends StatelessWidget implements PreferredSizeWidget {
  const TabBarBottomWidget({
    required this.child,
    required this.theme,
    super.key,
  });

  final Widget child;
  final ThemeProvider theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor?.withValues(alpha: 0.8),
      ),
      child: child,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class TabBarWrapper extends StatelessWidget implements PreferredSizeWidget {
  const TabBarWrapper({
    required this.child,
    required this.maxHeight,
    required this.padding,
    required this.theme,
    super.key,
  });

  final Widget child;
  final double maxHeight;
  final double padding;
  final ThemeProvider theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.backgroundColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          color: AppColor.themeColorGrey,
          borderRadius: BorderRadius.circular(24),
        ),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(maxHeight);
}
