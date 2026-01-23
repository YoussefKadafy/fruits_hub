import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/helpers/shared_prefs.dart';
import 'package:fruits_hub/core/routing/app_routes.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/features/onboaeding/data/onboarding_data_model.dart';
import 'package:fruits_hub/features/onboaeding/presentation/widgets/page_view_item.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:go_router/go_router.dart';

class PageViewSection extends StatefulWidget {
  const PageViewSection({super.key});

  @override
  State<PageViewSection> createState() => _PageViewSectionState();
}

class _PageViewSectionState extends State<PageViewSection> {
  late PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  final List<OnboardingDataModel> onboardingData = [
    OnboardingDataModel(
      background: AppAssets.assetsIconsOnboardingBackground1,
      mainImage: AppAssets.assetsIconsFruitBasketAmico1,
      heading: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(' مرحبًا بك في ', style: AppStyles.onboardingTitle),
          Text(
            ' Hub',
            style: AppStyles.onboardingTitle.copyWith(color: Colors.orange),
          ),
          Text(
            'Fruits',
            style: AppStyles.onboardingTitle.copyWith(color: AppColors.primary),
          ),
        ],
      ),
      description:
          ' استكشف مجموعتنا الواسعة من الفواكه الطازجة الممتازة واحصل على أفضل العروض والجودة العالية.',
    ),
    OnboardingDataModel(
      background: AppAssets.assetsIconsOnboardingBackground2,
      mainImage: AppAssets.assetsIconsPineappleCuate1,
      heading: Text('ابحث وتسوق', style: AppStyles.onboardingTitle),
      description:
          'نقدم لك أفضل الفواكه المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار الفاكهة المثالية',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return PageViewItem(
                backGround: data.background,
                mainImage: data.mainImage,
                heading: data.heading,
                description: data.description,
                skip: index != onboardingData.length - 1,
              );
            },
          ),
        ),
        64.height,
        DotsIndicator(
          dotsCount: onboardingData.length,
          position: currentIndex.toDouble(),
          decorator: DotsDecorator(
            activeColor: AppColors.primary,

            color: currentIndex == onboardingData.length - 1
                ? AppColors.primary
                : AppColors.lightPrimary,
            size: const Size.square(8),
            activeSize: const Size(8, 8),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        24.height,
        if (currentIndex == onboardingData.length - 1)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              onPressed: () async {
                await SharedPrefs.setOnboardingViewed(isOnboardingViewed: true);
                if (context.mounted) {
                  context.pushReplacementNamed(AppRoutes.login);
                }
              },
              text: 'ابدأ الأن',
              backgroundColor: AppColors.primary,
              textColor: AppColors.white,
            ),
          ),
      ],
    );
  }
}
