import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/utils/notification_circle.dart';
import 'package:fruits_hub/features/home/presentation/widgets/best_seller_body.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              splashColor: AppColors.green50,
              onPressed: () {},
              icon: NotificationCircle(),
            ),
          ],
          title: Text('الأكثر مبيعًا', style: AppStyles.wight700Size19),
        ),
        body: BestSellerBody(),
      ),
    );
  }
}
