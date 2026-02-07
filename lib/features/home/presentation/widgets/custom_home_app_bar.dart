import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/core/utils/notification_circle.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:svg_flutter/svg.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataMap = SharedPrefs.getUserData();

    final userName = userDataMap != null
        ? UserEntity.fromMap(userDataMap).name
        : 'Guest';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                child: SvgPicture.asset(AppAssets.assetsIconsProfile),
              ),
              11.width,
              Column(
                children: [
                  Text(
                    'صباح الخير !..',
                    style: AppStyles.wight700Size16.copyWith(
                      color: AppColors.grayScale,
                    ),
                  ),
                  2.height,
                  Text(userName, style: AppStyles.wight700Size16),
                ],
              ),
            ],
          ),
          NotificationCircle(),
        ],
      ),
    );
  }
}
