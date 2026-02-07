import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class NotificationCircle extends StatelessWidget {
  const NotificationCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.green50,
      radius: 16,
      child: SvgPicture.asset(AppAssets.assetsIconsNotification),
    );
  }
}
