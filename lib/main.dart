import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/core/routing/routes_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await SharedPrefs.init();
  runApp(const FruitsHub());
}

class FruitsHub extends StatelessWidget {
  const FruitsHub({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        title: 'Fruits Hub',
        routerConfig: RoutesConfig.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      ),
    );
  }
}
