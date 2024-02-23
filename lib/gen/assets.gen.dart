/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class $AssetsRiveGen {
  const $AssetsRiveGen();

  /// File path: assets/rive/monas_test.riv
  RiveGenImage get monasTest =>
      const RiveGenImage('assets/rive/monas_test.riv');

  /// List of all assets
  List<RiveGenImage> get values => [monasTest];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/anorganic_bottle_glass.svg
  SvgGenImage get anorganicBottleGlass =>
      const SvgGenImage('assets/svg/anorganic_bottle_glass.svg');

  /// File path: assets/svg/anorganic_milk.svg
  SvgGenImage get anorganicMilk =>
      const SvgGenImage('assets/svg/anorganic_milk.svg');

  /// File path: assets/svg/anorganic_newspaper.svg
  SvgGenImage get anorganicNewspaper =>
      const SvgGenImage('assets/svg/anorganic_newspaper.svg');

  /// File path: assets/svg/anorganic_soda_can.svg
  SvgGenImage get anorganicSodaCan =>
      const SvgGenImage('assets/svg/anorganic_soda_can.svg');

  /// File path: assets/svg/b3_battery.svg
  SvgGenImage get b3Battery => const SvgGenImage('assets/svg/b3_battery.svg');

  /// File path: assets/svg/b3_bulb.svg
  SvgGenImage get b3Bulb => const SvgGenImage('assets/svg/b3_bulb.svg');

  /// File path: assets/svg/b3_cigs.svg
  SvgGenImage get b3Cigs => const SvgGenImage('assets/svg/b3_cigs.svg');

  /// File path: assets/svg/jaki_title.svg
  SvgGenImage get jakiTitle => const SvgGenImage('assets/svg/jaki_title.svg');

  /// File path: assets/svg/organic_apple.svg
  SvgGenImage get organicApple =>
      const SvgGenImage('assets/svg/organic_apple.svg');

  /// File path: assets/svg/organic_bone.svg
  SvgGenImage get organicBone =>
      const SvgGenImage('assets/svg/organic_bone.svg');

  /// File path: assets/svg/organic_egg_shell.svg
  SvgGenImage get organicEggShell =>
      const SvgGenImage('assets/svg/organic_egg_shell.svg');

  /// File path: assets/svg/organic_fish_bone.svg
  SvgGenImage get organicFishBone =>
      const SvgGenImage('assets/svg/organic_fish_bone.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        anorganicBottleGlass,
        anorganicMilk,
        anorganicNewspaper,
        anorganicSodaCan,
        b3Battery,
        b3Bulb,
        b3Cigs,
        jakiTitle,
        organicApple,
        organicBone,
        organicEggShell,
        organicFishBone
      ];
}

class Assets {
  Assets._();

  static const $AssetsRiveGen rive = $AssetsRiveGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class RiveGenImage {
  const RiveGenImage(this._assetName);

  final String _assetName;

  RiveAnimation rive({
    String? artboard,
    List<String> animations = const [],
    List<String> stateMachines = const [],
    BoxFit? fit,
    Alignment? alignment,
    Widget? placeHolder,
    bool antialiasing = true,
    List<RiveAnimationController<dynamic>> controllers = const [],
    OnInitCallback? onInit,
  }) {
    return RiveAnimation.asset(
      _assetName,
      artboard: artboard,
      animations: animations,
      stateMachines: stateMachines,
      fit: fit,
      alignment: alignment,
      placeHolder: placeHolder,
      antialiasing: antialiasing,
      controllers: controllers,
      onInit: onInit,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}