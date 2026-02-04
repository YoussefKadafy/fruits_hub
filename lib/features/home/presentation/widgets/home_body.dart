import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/core/services/fire_base_auth_service.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final userDataMap = SharedPrefs.getUserData();

    final userData = UserEntity.fromMap(userDataMap!);
    return Column(children: [Text(userData.name)]);
  }
}
