import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:svg_flutter/svg_flutter.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.mainImage,
    required this.heading,
    required this.description,
    required this.backGround,
    required this.skip,
  });
  final String mainImage, description, backGround;
  final Widget heading;
  final bool skip;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,

          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(backGround, fit: BoxFit.fill),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: SvgPicture.asset(mainImage),
              ),
              if (skip)
                Positioned(
                  right: 0,
                  top: 0,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'تخطٍ',
                          style: AppStyles.wight600Size16.copyWith(
                            color: AppColors.disableTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        47.height,
        heading,
        24.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37.0),
          child: Text(
            description,
            style: AppStyles.onboardingDescription,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
