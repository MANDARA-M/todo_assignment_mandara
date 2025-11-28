
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../common_widgets/button_widget.dart';
import '../../constants/app_color.dart';
import '../../constants/margin.dart';
import '../../extensions/state_extensions.dart';
import '../../gen/assets.gen.dart';
import '../../l10n/app_localizations.dart';
import '../../navigation/navigation_utils.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../theme/theme_utils.dart';

class OnBoardingScreen extends StatefulHookConsumerWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnBoardingScreen> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen>
    with TickerProviderStateMixin {
  late final _localizations = AppLocalizations.of(context)!;

  late ThemeProvider _theme;

  int _currentPage = 0;
  late final pageController = PageController();

  final children = <OnBoardingData>[];
  bool _isAnimating = false;
  bool _isManualSwipe = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateData();
      refresh;
    });
  }

  void _populateData() {
    final onboardingImages = <OnBoardingData>[
      _getOnBoardingData(
        index: 0,
        image: Assets.lottie.onboardingNamasteIndia,
        title1: _localizations.onboardingTitle1Screen1,
        title2: _localizations.onboardingTitle2Screen1,
        subTitle: _localizations.onboardingSubTitle1Screen1,
      ),
      _getOnBoardingData(
        index: 1,
        image: Assets.lottie.onboardingJaiHindIndia,
        title1: _localizations.onboardingTitle1Screen2,
        title2: _localizations.onboardingTitle2Screen2,
        subTitle: _localizations.onboardingSubTitle1Screen2,
      ),
      _getOnBoardingData(
        index: 2,
        image: Assets.lottie.onboardingSocialMediaNetwork,
        title1: _localizations.onboardingTitle1Screen3,
        title2: _localizations.onboardingTitle2Screen3,
        subTitle: _localizations.onboardingSubTitle1Screen3,
      ),
      _getOnBoardingData(
        index: 3,
        image: Assets.lottie.onboardingSocialMediaMarketing,
        title1: _localizations.onboardingTitle1Screen5,
        title2: _localizations.onboardingTitle2Screen5,
        subTitle: _localizations.onboardingSubTitle1Screen5,
      ),
      _getOnBoardingData(
        index: 4,
        image: Assets.lottie.onboardingRepublicDay,
        title1: _localizations.onboardingTitle1Screen4,
        title2: _localizations.onboardingTitle2Screen4,
        subTitle: _localizations.onboardingSubTitle1Screen4,
      ),
    ];

    children.clear();
    children.addAll(onboardingImages);

    // Start the first animation
    _startCurrentPageAnimation();
  }

  void _startCurrentPageAnimation() {
    if (_currentPage < children.length) {
      final item = children[_currentPage];
      // Only start animation if controller has a duration set
      if (item.controller.duration != null) {
        item.controller.reset();
        item.controller.forward();
        refresh;
      } else {
        // If duration is not set yet, wait a bit and try again
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && _currentPage < children.length) {
            final currentItem = children[_currentPage];
            if (currentItem.controller.duration != null) {
              currentItem.controller.reset();
              currentItem.controller.forward();
              // Update the UI to reflect the animation start
              refresh;
            }
          }
        });
      }

      // Reset manual swipe flag after a delay to allow automatic progression
      if (_isManualSwipe) {
        Future.delayed(const Duration(milliseconds: 3000), () {
          if (mounted) {
            _isManualSwipe = false;
          }
        });
      }
    }
  }

  void _onAnimationCompleted() {
    if (_isAnimating || _isManualSwipe) {
      return;
    }

    _isAnimating = true;

    // Add a delay before moving to next page to let user see the completed animation
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _handlePageLoop();
      }
    });
  }

  void _navigateToNextScreen() {
    NavigationUtils.instance.onBoardingCompleted(context);
  }

  void _handlePageLoop() {
    _currentPage = (_currentPage >= children.length - 1) ? 0 : ++_currentPage;
    _animateToPage();
    /*
    if (_currentPage >= children.length - 1) {
      _currentPage = 0;
      _animateToPage();
    } else {
      // Move to next page
      _currentPage++;
      _animateToPage();
    }*/

    refresh;
  }

  void _animateToPage() {
    pageController
        .animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _isAnimating = false;
      _startCurrentPageAnimation();
      // Update the UI to reflect the page change
      refresh;
    });
  }

  void _checkForLooping() {
    // Only check for looping if we're at the last page and it's a manual swipe
    // Don't loop immediately - let the animation complete first
    if (_currentPage >= children.length - 1 && _isManualSwipe) {
      // Reset the manual swipe flag and let the animation complete
      // The looping will be handled by the animation completion listener
      _isManualSwipe = false;
    }
  }

  @override
  void dispose() {
    // Dispose all animation controllers
    for (final item in children) {
      item.controller.dispose();
    }
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = ref.watch(themeProvider);

    //_populateData();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _bodyPartUI(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: _bottomButton(),
        ),
      ),
    );
  }

  OnBoardingData _getOnBoardingData({
    required LottieGenImage image,
    required int index,
    required String title1,
    required String title2,
    required String subTitle,
  }) {
    final controller = AnimationController(vsync: this);

    // Add listener only for the current page's animation
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && index == _currentPage) {
        // Add a small delay before moving to next page
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && index == _currentPage && !_isManualSwipe) {
            _onAnimationCompleted();
          }
        });
      }
    });

    return OnBoardingData(
      image: image,
      controller: controller,
      title1: title1,
      title2: title2,
      subTitle: subTitle,
    );
  }

  Widget _bodyPartUI() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  _currentPage = index;
                  _isManualSwipe = true;
                  // Check if we need to loop back to first page
                  _checkForLooping();
                  // Start animation for the new current page when user swipes
                  _startCurrentPageAnimation();
                  // Update the UI to reflect the page change
                  refresh;
                },
                children: children
                    .map((item) => _onBoardingScreenNew(item: item))
                    .toList(),
              ),
            ),
            DotsIndicator(
              dotsCount: children.length,
              position: _currentPage.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColor.primaryLight,
                color: AppColor.primaryLight.withValues(alpha: 0.3),
                activeSize: const Size(20.0, 8.0),
                size: const Size(16.0, 6.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              NavigationUtils.instance
                  .onBoardingCompleted(context, isSkip: true);
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Skip'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _onBoardingScreenNew({required OnBoardingData item}) {
    final image = item.image;
    final _controller = item.controller;

    final childAnimation = Lottie.asset(
      image.path,
      controller: _controller,
      repeat: false,
      fit: BoxFit.contain,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        // Only start animation if this is the current page and we're not in the middle of a manual swipe
        if (children.indexOf(item) == _currentPage && !_isAnimating) {
          _controller.reset();
          _controller.forward();
        }
      },
    );

    final textColor = AppColor.black70;

    return Column(
      children: [
        Expanded(
          child: childAnimation,
          //_screenTitle(),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //_unicodeText,
              Margin.vertical8,
              Text(
                item.title1,
                style: _theme.ts.extTs32
                    .copyWith(color: textColor, fontWeight: FontWeight.w600),
              ),
              Text(
                item.title2,
                style: GoogleFonts.openSans(
                  textStyle: _theme.ts.extTs40.copyWith(
                      color: AppColor.purpleColor, fontWeight: FontWeight.w800),
                ),
              ),
              //headingText(item.title1, color: textColor),
              //headingText(item.title2, color: AppColor.purpleColor),
              Margin.vertical42,
              Text(
                item.subTitle,
                style: GoogleFonts.openSans(
                  textStyle: _theme.ts.extTs14.copyWith(color: textColor),
                ),
                //style: _theme.ts.extTs14.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              Margin.vertical16,
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomButton() {
    return ButtonWidget(
      title: _localizations.signInWithMobile,
      onPressed: _navigateToNextScreen,
    );
  }
}

class OnBoardingData {
  OnBoardingData({
    required this.image,
    required this.controller,
    required this.title1,
    required this.title2,
    required this.subTitle,
  });

  final LottieGenImage image;
  final AnimationController controller;
  final String title1;
  final String title2;
  final String subTitle;
}
