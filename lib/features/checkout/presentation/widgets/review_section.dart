import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/row_text_widget.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملخص الطلب :', style: AppStyles.wight700Size13),
        24.height,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.lightGrayWith50Opacity,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              RowTextWidget(
                actionText: 'المجموع الفرعي',
                resultText: " 150 جنيه",
              ),
              8.height,

              RowTextWidget(
                actionText: 'التوصيل',
                resultText: " 30 جنيه",
                resultColor: AppColors.grayScale500,
              ),
              8.height,
              Divider(color: AppColors.grayScale),
              8.height,

              RowTextWidget(
                actionText: 'المجموع الكلي',
                resultText: " 180 جنيه",
                actionColor: AppColors.black,
              ),
            ],
          ),
        ),
        24.height,
        Text('عنوان التوصيل :', style: AppStyles.wight700Size13),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.lightGrayWith50Opacity,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined, color: AppColors.primary),
                    8.width,
                    Expanded(
                      child: Text(
                        ' الجيزة - ترسا - شارع 10- عمارة 14 - شقة 4',
                        style: AppStyles.wight700Size13,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton( style:  TextButton.styleFrom(
overlayColor: AppColors.mintGreen   
              ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [                 
                    Icon(Icons.mode_edit, size: 18, color: AppColors.primary ,),
                  4.width,
                    Text(
                      'تعديل',
                      style: AppStyles.wight700Size13.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
   ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
