import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/features/add_product/presentation/views/add_product_view.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:fruits_hub/features/cart/presentation/views/cart_view.dart';
import 'package:fruits_hub/features/home/presentation/views/home_view.dart';
import 'package:fruits_hub/features/main/domain/entities/nav_bar_entity.dart';
import 'package:fruits_hub/features/main/presentation/widgets/custom_nav_bar_widget.dart';
import 'package:fruits_hub/features/products/presentation/views/products_view.dart';
import 'package:fruits_hub/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fruits_hub/features/profile/presentation/views/profile_view.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PersistentTabController _controller;
  bool isAdmin = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final authRepo = locator<AuthRepo>();
        final userEntity = await authRepo.getUserData(userId: user.uid);
        setState(() {
          isAdmin = userEntity.role == 'admin';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error checking user role: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    if (isAdmin) {
      return [
        const HomeView(),
        const ProductsView(),
        const AddProductView(),
        const CartView(),
        const ProfileView(),
      ];
    } else {
      return [
        const HomeView(),
        const ProductsView(),
        const CartView(),
        const ProfileView(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return PersistentTabView.custom(
      context,
      controller: _controller,
      itemCount: isAdmin
          ? NavBarEntity.adminNavBarItems.length
          : NavBarEntity.navBarItems.length,
      screens: _buildScreens()
          .map((screen) => CustomNavBarScreen(screen: screen))
          .toList(),
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      customWidget: CustomNavBarWidget(
        items: isAdmin
            ? NavBarEntity.adminNavBarItems
            : NavBarEntity.navBarItems,
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
