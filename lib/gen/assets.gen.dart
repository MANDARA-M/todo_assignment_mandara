// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart' as _lottie;

class $AssetsAppiconGen {
  const $AssetsAppiconGen();

  /// File path: assets/appicon/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/appicon/app_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/alert_icon.png
  AssetGenImage get alertIcon =>
      const AssetGenImage('assets/images/alert_icon.png');

  /// File path: assets/images/arrow_previous.png
  AssetGenImage get arrowPrevious =>
      const AssetGenImage('assets/images/arrow_previous.png');

  /// File path: assets/images/astronaut_nointernet.png
  AssetGenImage get astronautNointernet =>
      const AssetGenImage('assets/images/astronaut_nointernet.png');

  /// File path: assets/images/close_dark.png
  AssetGenImage get closeDark =>
      const AssetGenImage('assets/images/close_dark.png');

  /// File path: assets/images/close_light.png
  AssetGenImage get closeLight =>
      const AssetGenImage('assets/images/close_light.png');

  /// File path: assets/images/error.png
  AssetGenImage get error => const AssetGenImage('assets/images/error.png');

  /// Directory path: assets/images/profile
  $AssetsImagesProfileGen get profile => const $AssetsImagesProfileGen();

  /// List of all assets
  List<AssetGenImage> get values => [
    alertIcon,
    arrowPrevious,
    astronautNointernet,
    closeDark,
    closeLight,
    error,
  ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/onboarding_jai_hind_india.json
  LottieGenImage get onboardingJaiHindIndia =>
      const LottieGenImage('assets/lottie/onboarding_jai_hind_india.json');

  /// File path: assets/lottie/onboarding_namaste_india.json
  LottieGenImage get onboardingNamasteIndia =>
      const LottieGenImage('assets/lottie/onboarding_namaste_india.json');

  /// File path: assets/lottie/onboarding_republic_day.json
  LottieGenImage get onboardingRepublicDay =>
      const LottieGenImage('assets/lottie/onboarding_republic_day.json');

  /// File path: assets/lottie/onboarding_social_media_marketing (transparent background).json
  LottieGenImage
  get onboardingSocialMediaMarketingTransparentBackground => const LottieGenImage(
    'assets/lottie/onboarding_social_media_marketing (transparent background).json',
  );

  /// File path: assets/lottie/onboarding_social_media_marketing.json
  LottieGenImage get onboardingSocialMediaMarketing => const LottieGenImage(
    'assets/lottie/onboarding_social_media_marketing.json',
  );

  /// File path: assets/lottie/onboarding_social_media_network.json
  LottieGenImage get onboardingSocialMediaNetwork => const LottieGenImage(
    'assets/lottie/onboarding_social_media_network.json',
  );

  /// List of all assets
  List<LottieGenImage> get values => [
    onboardingJaiHindIndia,
    onboardingNamasteIndia,
    onboardingRepublicDay,
    onboardingSocialMediaMarketingTransparentBackground,
    onboardingSocialMediaMarketing,
    onboardingSocialMediaNetwork,
  ];
}

class $AssetsImagesProfileGen {
  const $AssetsImagesProfileGen();

  /// File path: assets/images/profile/astronaut_profile_icon.png
  AssetGenImage get astronautProfileIcon =>
      const AssetGenImage('assets/images/profile/astronaut_profile_icon.png');

  /// File path: assets/images/profile/logout.png
  AssetGenImage get logout =>
      const AssetGenImage('assets/images/profile/logout.png');

  /// File path: assets/images/profile/profile_icon.png
  AssetGenImage get profileIcon =>
      const AssetGenImage('assets/images/profile/profile_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [astronautProfileIcon, logout, profileIcon];
}

class Assets {
  const Assets._();

  static const $AssetsAppiconGen appicon = $AssetsAppiconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class LottieGenImage {
  const LottieGenImage(this._assetName, {this.flavors = const {}});

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, _lottie.LottieComposition?)?
    frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
