import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/domain/entities/nav_bar_entity.dart';

class UnselectedNavBarItem extends StatelessWidget {
  final NavBarEntity item;

  const UnselectedNavBarItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [item.icon],
    );
  }
}
