import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: value ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: value ? AppColors.primary : AppColors.borderColor,
            width: 1.5,
          ),
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
                weight: 1000,
              )
            : null,
      ),
    );
  }
}
