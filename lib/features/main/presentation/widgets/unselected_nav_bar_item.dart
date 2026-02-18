import 'package:flutter/material.dart';
import 'package:fruits_hub/features/main/domain/entities/nav_bar_entity.dart';

class UnselectedNavBarItem extends StatelessWidget {
  final NavBarEntity item;

  const UnselectedNavBarItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        color: Colors.transparent,
        child: Center(child: SizedBox(width: 48, height: 48, child: item.icon)),
      ),
    );
  }
}
