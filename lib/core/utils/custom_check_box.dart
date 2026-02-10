import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final bool isError;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.isError = false, // ✅ default value
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: value ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isError
                ? Colors.red
                : (value ? AppColors.primary : AppColors.borderColor),
            width: isError ? 2 : 1.5, // ✅ أعرض لما يكون فيه خطأ
          ),
        ),
        child: value
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}
