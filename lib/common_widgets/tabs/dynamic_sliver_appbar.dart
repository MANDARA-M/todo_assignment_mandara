import 'dart:async';

import 'package:flutter/material.dart';

import '../../extensions/state_extensions.dart';

class DynamicSliverAppBar extends StatefulWidget {
  const DynamicSliverAppBar({
    required this.child,
    required this.maxHeight,
    this.bottom,
    this.snap,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double maxHeight;
  final bool? snap;

  /// This property is used to configure an [AppBar].
  final PreferredSizeWidget? bottom;

  @override
  _DynamicSliverAppBarState createState() => _DynamicSliverAppBarState();
}

class _DynamicSliverAppBarState extends State<DynamicSliverAppBar> {
  final GlobalKey _childKey = GlobalKey();
  bool isHeightCalculated = false;
  double? height;

  bool get snap => widget.snap ?? false;

  @override
  void initState() {
    super.initState();
    _handlePostFrameCallback();
  }

  void _handlePostFrameCallback() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _calculateHeight();
      Timer.periodic(const Duration(seconds: 5), (timer) {
        timer.cancel();
        _calculateHeight();
      });
    });
  }

  void _calculateHeight() {
    try {
      isHeightCalculated = true;
      height = (_childKey.currentContext!.findRenderObject()! as RenderBox).size.height;
      refresh;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: isHeightCalculated ? height : widget.maxHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              NotificationListener<SizeChangedLayoutNotification>(
                onNotification: (notification) {
                  _handlePostFrameCallback();
                  return false;
                },
                child: SizeChangedLayoutNotifier(
                  child: Container(
                    key: _childKey,
                    child: widget.child,
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
      elevation: 0.0,
      floating: true,
      pinned: true,
      snap: snap,
      //stretch: true,
      automaticallyImplyLeading: false,
      bottom: widget.bottom,
    );
  }
}
