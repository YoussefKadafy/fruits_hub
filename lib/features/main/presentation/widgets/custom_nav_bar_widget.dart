import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/features/main/domain/entities/nav_bar_entity.dart';
import 'package:fruits_hub/features/main/presentation/widgets/selected_nav_bar_item.dart';
import 'package:fruits_hub/features/main/presentation/widgets/unselected_nav_bar_item.dart';

class CustomNavBarWidget extends StatelessWidget {
  final List<NavBarEntity> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomNavBarWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 70.h + bottomPadding,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grayScale,
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding, top: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => _NavBarItemButton(
              item: items[index],
              isSelected: selectedIndex == index,
              onTap: () => onItemSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItemButton extends StatelessWidget {
  final NavBarEntity item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItemButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: isSelected
          ? SelectedNavBarItem(item: item)
          : UnselectedNavBarItem(item: item),
    );
  }
}
