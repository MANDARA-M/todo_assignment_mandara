import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/app_color.dart';
import '../../gen/assets.gen.dart';
import '../../navigation/navigation_utils.dart';
import '../../providers/auth_provider.dart';
import '../../providers/utils/provider_utility.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late AuthProvider _auth;

  int get animationTimeInSeconds => kDebugMode ? 3 : 3;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    Timer.periodic(Duration(seconds: animationTimeInSeconds), (timer) {
      timer.cancel();
      NavigationUtils.instance.checkAppStateAndProceedFurther(this, auth: _auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    _auth = ref.watch(authProvider);

    return _mainWidget;
  }

  Widget get _mainWidget {
    return Scaffold(
      /*body: BaseWidgetWrapper(
        child: AudioPlayerWidgetWrapper(
          child: _mainWidgetScreens,
        ),
      ),*/
      body: _mainWidgetScreens,
    );
  }

  Widget get _mainWidgetScreens {
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: Duration(seconds: animationTimeInSeconds),
        tween: Tween<double>(begin: 0.3, end: 1.0),
        curve: Curves.easeOutBack,
        builder: (_, scale, myChild) {
          return Transform.scale(
            scale: scale,
            child: TweenAnimationBuilder<Color?>(
              duration: const Duration(seconds: 5),
              tween: ColorTween(begin: AppColor.white10, end: AppColor.white),
              builder: (_, color, myChild) {
                return ColorFiltered(colorFilter: ColorFilter.mode(color ?? Colors.white, BlendMode.modulate), child: myChild ?? const SizedBox.shrink());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Assets.appicon.appIcon.image(
                  height: 220,
                  width: 220,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
