import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:fruits_hub/features/profile/presentation/widgets/profile_body.dart';
import 'package:fruits_hub/core/helpers/service_locator.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ProfileCubit>(),
      child: const ProfileBody(),
    );
  }
}
