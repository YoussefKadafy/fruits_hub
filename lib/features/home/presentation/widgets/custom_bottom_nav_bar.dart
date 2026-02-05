import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/features/home/domain/entities/nav_bar_entity.dart';
import 'package:fruits_hub/features/home/presentation/widgets/selected_nav_bar_item.dart';
import 'package:fruits_hub/features/home/presentation/widgets/unselected_nav_bar_item.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grayScale,
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            NavBarEntity.navBarItems.length,
            (index) => _buildNavBarItem(index),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(int index) {
    final item = NavBarEntity.navBarItems[index];
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: isSelected
          ? SelectedNavBarItem(item: item)
          : UnselectedNavBarItem(item: item),
    );
  }
}
