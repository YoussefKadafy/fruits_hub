import 'package:flutter/material.dart';
import 'package:fruits_hub/core/routing/routes_config.dart';

void main() {
  runApp(const FruitsHub());
}

class FruitsHub extends StatelessWidget {
  const FruitsHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fruits Hub',
      routerConfig: RoutesConfig.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
