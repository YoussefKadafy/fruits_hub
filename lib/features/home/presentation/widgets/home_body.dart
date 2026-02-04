import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = SharedPrefs.getUserData();
    return Column(children: [Text('${userData!['name']}')]);
  }
}
