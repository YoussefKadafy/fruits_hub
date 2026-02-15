import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/admin/services/supabase_service.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/helpers/custom_bloc_observer.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';

import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/core/routing/routes_config.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();

  Bloc.observer = CustomBlocObserver();
  setupServiceLocator();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        title: 'Fruits Hub',
        routerConfig: RoutesConfig.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          useMaterial3: true,
          fontFamily: 'Cairo',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}
