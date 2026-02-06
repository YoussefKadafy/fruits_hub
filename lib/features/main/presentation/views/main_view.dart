import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/features/home/domain/entities/nav_bar_entity.dart';
import 'package:fruits_hub/features/home/presentation/views/home_view.dart';
import 'package:fruits_hub/features/products/presentation/views/products_view.dart';
import 'package:fruits_hub/features/cart/presentation/views/cart_view.dart';
import 'package:fruits_hub/features/profile/presentation/views/profile_view.dart';
import 'package:fruits_hub/features/home/presentation/widgets/selected_nav_bar_item.dart';
import 'package:fruits_hub/features/home/presentation/widgets/unselected_nav_bar_item.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return const [HomeView(), ProductsView(), CartView(), ProfileView()];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      controller: _controller,
      itemCount: NavBarEntity.navBarItems.length,
      screens: _buildScreens()
          .map((screen) => CustomNavBarScreen(screen: screen))
          .toList(),
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,

      customWidget: CustomNavBarWidget(
        items: NavBarEntity.navBarItems,
        selectedIndex: _controller.index,
        onItemSelected: (index) {
          setState(() {
            _controller.jumpToTab(index);
          });
        },
      ),
    );
  }
}

class CustomNavBarWidget extends StatelessWidget {
  final List<NavBarEntity> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomNavBarWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grayScale,
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () => onItemSelected(index),
              child: selectedIndex == index
                  ? SelectedNavBarItem(item: items[index])
                  : UnselectedNavBarItem(item: items[index]),
            ),
          ),
        ),
      ),
    );
  }
}
