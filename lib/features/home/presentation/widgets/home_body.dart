import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/search_text_field.dart';
import 'package:fruits_hub/features/home/presentation/views/best_seller_view.dart';
import 'package:fruits_hub/features/home/presentation/widgets/best_seller_body.dart';
import 'package:fruits_hub/core/utils/headline_and_action.dart';
import 'package:fruits_hub/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:fruits_hub/features/home/presentation/widgets/featured_items_list.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                16.height,
                CustomHomeAppBar(),
                24.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: SearchTextField(controller: TextEditingController()),
                ),
                19.height,
                FeaturedItemsList(),
                12.height,
                HeadlineAndAction(
                  headline: 'الأكثر مبيعاً',
                  action: Text(
                    'المزيد',
                    style: AppStyles.wight400Size13.copyWith(
                      color: AppColors.grayScale,
                    ),
                  ),
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const BestSellerView(),
                      withNavBar: true, // Keep the bottom nav bar visible
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                ),
                8.height,
              ],
            ),
          ),

          BestSellerBody(),
        ],
      ),
    );
  }
}
