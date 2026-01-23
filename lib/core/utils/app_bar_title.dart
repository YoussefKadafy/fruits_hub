import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyles.wight700Size19,
      textAlign: TextAlign.center,
    );
  }
}
