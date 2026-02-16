import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/admin/services/supabase_service.dart';
import 'package:fruits_hub/core/helpers/custom_bloc_observer.dart';
import 'package:fruits_hub/core/helpers/env_loader.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';

import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'fruits_hub.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from assets
  await EnvLoader.load();
  await SupabaseService.initialize();

  Bloc.observer = CustomBlocObserver();
  setupServiceLocator();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize SharedPreferences
  await SharedPrefs.init();
  runApp(const FruitsHub());
}
