import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FruitItem extends StatelessWidget {
  final ProductEntity? product;

  final bool enabled;
  final void Function()? onTap;

  const FruitItem({super.key, this.product, required this.enabled, this.onTap});

  @override
  Widget build(BuildContext context) {
    final name = product?.name ?? 'فراولة';
    final price = product?.price ?? 200;
    final imageUrl = product?.imageUrl;

    return Skeletonizer(
      enabled: enabled,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🖼 Image Section
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: imageUrl != null && imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              AppAssets.assetsImagesStrawberry,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            AppAssets.assetsImagesStrawberry,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

                12.height,

                /// 📝 Product Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.wight600Size14,
                      ),

                      6.height,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: '$price ج.م ',
                              style: AppStyles.wight600Size14.copyWith(
                                color: AppColors.secondary,
                              ),
                              children: [
                                TextSpan(
                                  text: '/  ${product?.unitAmount ?? 'كيلو'} ',
                                  style: AppStyles.wight400Size13.copyWith(
                                    color: AppColors.lightSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// ➕ Add Button
                          InkWell(
                            onTap: onTap,
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                12.height,
              ],
            ),

            /// ❤️ Favorite Icon
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 18,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
