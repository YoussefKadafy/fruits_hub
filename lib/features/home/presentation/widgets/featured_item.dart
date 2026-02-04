import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/home/presentation/widgets/featured_button.dart';

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: 342 / 158,
        child: Stack(
          children: [
            Container(
              width: width * .9,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppAssets.assetsImagesStrawberry),
                ),
              ),
            ),
            Container(
              width: width * .5,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Svg(AppAssets.assetsIconsFeaturedBackground),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عروض العيد',
                    style: AppStyles.wight400Size13.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  8.height,
                  Text(
                    'خصم 25%',
                    style: AppStyles.wight700Size19.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  7.height,
                  FeaturedButton(onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
