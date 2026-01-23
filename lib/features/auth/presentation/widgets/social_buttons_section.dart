import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/social_auth.dart';
import 'package:svg_flutter/svg.dart';

class SocialButtonsSection extends StatelessWidget {
  const SocialButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialButton(
          icon: SvgPicture.asset(AppAssets.assetsIconsGoogle),
          text: 'تسجيل الدخول بواسطة Google',
          onTap: () {},
        ),
        12.height,

        SocialButton(
          icon: SvgPicture.asset(AppAssets.assetsIconsApple),
          text: 'تسجيل الدخول بواسطة Apple',
          onTap: () {},
        ),
        12.height,
        SocialButton(
          icon: SvgPicture.asset(AppAssets.assetsIconsFacebook),
          text: 'تسجيل الدخول بواسطة Facebook',
          onTap: () {},
        ),
      ],
    );
  }
}
