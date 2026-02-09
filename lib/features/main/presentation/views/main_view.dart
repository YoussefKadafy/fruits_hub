import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';
import 'package:fruits_hub/features/add_product/presentation/views/add_product_view.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fruits_hub/features/cart/presentation/views/cart_view.dart';
import 'package:fruits_hub/features/home/presentation/views/home_view.dart';
import 'package:fruits_hub/features/main/domain/entities/nav_bar_entity.dart';
import 'package:fruits_hub/features/main/presentation/widgets/custom_nav_bar_widget.dart';
import 'package:fruits_hub/features/products/presentation/views/products_view.dart';
import 'package:fruits_hub/features/profile/presentation/views/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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

  List<Widget> _buildScreens(bool isAdmin) {
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
    return BlocProvider(
      create: (context) =>
          locator<AuthCubit>()
            ..startListeningToUser(FirebaseAuth.instance.currentUser!.uid),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthError) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else if (state is AuthAuthenticated) {
            final isAdmin = state.user.role == 'admin';
            return PersistentTabView.custom(
              context,
              controller: _controller,
              itemCount: isAdmin
                  ? NavBarEntity.adminNavBarItems.length
                  : NavBarEntity.navBarItems.length,
              screens: _buildScreens(
                isAdmin,
              ).map((screen) => CustomNavBarScreen(screen: screen)).toList(),
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
          } else {
            return const Scaffold(
              body: Center(child: Text('User not authenticated')),
            );
          }
        },
      ),
    );
  }
}
