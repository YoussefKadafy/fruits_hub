import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:svg_flutter/svg.dart';

class NavBarEntity {
  final String focusedLabel;
  final String iconPath;
  final String activeIconPath;

  const NavBarEntity({
    required this.focusedLabel,
    required this.iconPath,
    required this.activeIconPath,
  });

  // Lazy widget creation instead of storing widgets
  Widget get icon => SvgPicture.asset(iconPath, height: 24.h, width: 24.w);

  Widget get activeIcon => SvgPicture.asset(activeIconPath);

  static const List<NavBarEntity> navBarItems = [
    NavBarEntity(
      focusedLabel: 'الرئيسية',
      iconPath: AppAssets.assetsIconsHome,
      activeIconPath: AppAssets.assetsIconsFocusedHome,
    ),
    NavBarEntity(
      focusedLabel: 'المنتجات',
      iconPath: AppAssets.assetsIconsProducts,
      activeIconPath: AppAssets.assetsIconsFocusedProducts,
    ),
    NavBarEntity(
      focusedLabel: 'عربة التسوق',
      iconPath: AppAssets.assetsIconsShoppingCart,
      activeIconPath: AppAssets.assetsIconsFocusedShoppingCart,
    ),
    NavBarEntity(
      focusedLabel: 'حسابي',
      iconPath: AppAssets.assetsIconsUser,
      activeIconPath: AppAssets.assetsIconsFocusedUser,
    ),
  ];
}
