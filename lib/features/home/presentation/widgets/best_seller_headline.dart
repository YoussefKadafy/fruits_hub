import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/features/home/presentation/views/best_seller_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BestSellerHeadline extends StatelessWidget {
  const BestSellerHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('الأكثر مبيعاً', style: AppStyles.wight700Size16),
          InkWell(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const BestSellerView(),
                withNavBar: true, // Keep the bottom nav bar visible
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            splashColor: AppColors.green50,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'المزيد',
                style: AppStyles.wight400Size13.copyWith(
                  color: AppColors.grayScale,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
