import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class _LogColor {
  static const String reset = '\x1B[0m';
  static const String cyan = '\x1B[36m';
  static const String green = '\x1B[32m';
  static const String blue = '\x1B[34m';
  static const String yellow = '\x1B[33m';
  static const String red = '\x1B[31m';
  static const String magenta = '\x1B[35m';

  static String colored(String message, String color) {
    return '$color$message$reset';
  }
}

class CustomBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    final message = 'onCreate -- ${bloc.runtimeType}';
    log(_LogColor.colored(message, _LogColor.cyan));
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    final message = 'onEvent -- ${bloc.runtimeType}, event: $event';
    log(_LogColor.colored(message, _LogColor.magenta));
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    final message = 'onChange -- ${bloc.runtimeType}, change: $change';
    log(_LogColor.colored(message, _LogColor.green));
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    final message =
        'onTransition -- ${bloc.runtimeType}, transition: $transition';
    log(_LogColor.colored(message, _LogColor.yellow));
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    final message =
        'onError -- ${bloc.runtimeType}, error: $error, stackTrace: $stackTrace';
    log(_LogColor.colored(message, _LogColor.red));
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    final message = 'onClose -- ${bloc.runtimeType}';
    log(_LogColor.colored(message, _LogColor.magenta));
  }
}
