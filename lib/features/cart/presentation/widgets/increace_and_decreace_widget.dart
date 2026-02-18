import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';

class IncreaceAndDecreaceWidget extends StatelessWidget {
  final int count;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final bool canDecrease;

  const IncreaceAndDecreaceWidget({
    super.key,
    required this.count,
    required this.onIncrease,
    required this.onDecrease,
    this.canDecrease = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          icon: Icons.add,
          color: AppColors.primary,
          iconColor: Colors.white,
          onTap: onIncrease,
        ),

        16.width,

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Text(
            '$count',
            key: ValueKey(count),
            style: AppStyles.wight700Size16,
          ),
        ),

        16.width,

        _CircleButton(
          icon: Icons.remove,
          color: canDecrease ? AppColors.lightGray : Colors.grey.shade300,
          iconColor: AppColors.onboardingDescriptionTextColor,
          onTap: canDecrease ? onDecrease : null,
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback? onTap;

  const _CircleButton({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        splashColor: AppColors.green50,
        child: Ink(
          height: 32.h, // 🔥 bigger tap area (UX improvement)
          width: 32.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Icon(icon, color: iconColor, size: 18),
        ),
      ),
    );
  }
}
