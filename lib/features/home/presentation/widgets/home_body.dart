import 'package:flutter/material.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/search_text_field.dart';
import 'package:fruits_hub/features/home/presentation/widgets/custom_home_app_bar.dart';
import 'package:fruits_hub/features/home/presentation/widgets/featured_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomHomeAppBar(),
                24.height,
                SearchTextField(controller: TextEditingController()),
                19.height,
                FeaturedItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
