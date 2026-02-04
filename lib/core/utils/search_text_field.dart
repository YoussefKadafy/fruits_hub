import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:svg_flutter/svg.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.controller, this.onChanged});
  final TextEditingController controller;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.green50,
            blurRadius: 8, // كلما زادت كلما انتشر الظل أكثر
            spreadRadius: 1, // انتشار الظل
            offset: Offset(2, 2), // موضع الظل
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: onChanged,

        cursorColor: AppColors.primary,
        cursorWidth: 1.5.w,
        style: AppStyles.wight600Size16,
        decoration: InputDecoration(
          hintText: 'ابحث عن.....',
          fillColor: AppColors.white,
          filled: true,

          hintStyle: AppStyles.wight400Size14.copyWith(
            color: AppColors.grayScale,
          ),
          prefixIcon: SvgPicture.asset(
            AppAssets.assetsIconsSearch,
            height: 20.h,
            width: 20.w,
            fit: BoxFit.scaleDown,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          suffixIcon: SvgPicture.asset(
            AppAssets.assetsIconsFilter,
            fit: BoxFit.scaleDown,

            height: 20.h,
            width: 20.w,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: Color(0xffE6E9EA), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: BorderSide(color: Color(0xffE6E9EA), width: 1),
          ),
        ),
      ),
    );
  }
}
