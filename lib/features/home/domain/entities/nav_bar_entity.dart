import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:svg_flutter/svg.dart';

class NavBarEntity {
  final String focusedLabel;
  final Widget icon;
  final Widget activeIcon;

  const NavBarEntity({
    required this.focusedLabel,
    required this.icon,
    required this.activeIcon,
  });

  static List<NavBarEntity> navBarItems = [
    NavBarEntity(
      focusedLabel: 'الرئيسية',
      icon: SvgPicture.asset(
        AppAssets.assetsIconsHome,
        height: 24.h,
        width: 24.w,
      ),
      activeIcon: SvgPicture.asset(AppAssets.assetsIconsFocusedHome),
    ),
    NavBarEntity(
      focusedLabel: 'المنتجات',
      icon: SvgPicture.asset(
        AppAssets.assetsIconsProducts,
        height: 24.h,
        width: 24.w,
      ),
      activeIcon: SvgPicture.asset(AppAssets.assetsIconsFocusedProducts),
    ),
    NavBarEntity(
      focusedLabel: 'عربة التسوق',
      icon: SvgPicture.asset(
        AppAssets.assetsIconsShoppingCart,
        height: 24.h,
        width: 24.w,
      ),
      activeIcon: SvgPicture.asset(AppAssets.assetsIconsFocusedShoppingCart),
    ),
    NavBarEntity(
      focusedLabel: 'حسابي',
      icon: SvgPicture.asset(
        AppAssets.assetsIconsUser,
        height: 24.h,
        width: 24.w,
      ),
      activeIcon: SvgPicture.asset(AppAssets.assetsIconsFocusedUser),
    ),
  ];
}
