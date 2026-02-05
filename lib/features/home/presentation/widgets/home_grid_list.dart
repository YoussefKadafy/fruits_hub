import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/presentation/widgets/fruite_item.dart';

class HomeGridList extends StatelessWidget {
  const HomeGridList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 163 / 214,
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return FruitItem();
      },
    );
  }
}
