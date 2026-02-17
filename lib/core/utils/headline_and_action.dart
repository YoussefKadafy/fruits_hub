import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';

class HeadlineAndAction extends StatelessWidget {
  const HeadlineAndAction({
    super.key,
    required this.headline,
    required this.action,
    this.onTap,
  });
  final String headline;
  final Widget action;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(headline, style: AppStyles.wight700Size16),
          InkWell(
            onTap: onTap,
            splashColor: AppColors.green50,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(padding: const EdgeInsets.all(8.0), child: action),
          ),
        ],
      ),
    );
  }
}
