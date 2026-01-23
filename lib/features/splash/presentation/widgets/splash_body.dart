import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:svg_flutter/svg.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(AppAssets.assetsIconsUpperSplashImage),
        ),
        SvgPicture.asset(AppAssets.assetsIconsMainSplashImage),
        SvgPicture.asset(AppAssets.assetsIconsBottomSplashImage),
      ],
    );
  }
}
