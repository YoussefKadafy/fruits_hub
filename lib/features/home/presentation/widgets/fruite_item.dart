import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';

class FruitItem extends StatelessWidget {
  const FruitItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.lightGray,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                17.height,
                Image.asset(AppAssets.assetsImagesStrawberry),
                24.height,
                ListTile(
                  title: Text('فراولة', style: AppStyles.wight600Size13),

                  subtitle: Text.rich(
                    TextSpan(
                      text: '200 ج.م',
                      children: [
                        TextSpan(
                          text: '/',
                          style: AppStyles.wight600Size13.copyWith(
                            color: AppColors.lightSecondary,
                          ),
                        ),
                        TextSpan(
                          text: 'كيلو',
                          style: AppStyles.wight600Size13.copyWith(
                            color: AppColors.lightSecondary,
                          ),
                        ),
                      ],
                      style: AppStyles.wight600Size13.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
