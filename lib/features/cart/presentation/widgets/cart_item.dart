import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';
import 'package:fruits_hub/features/cart/presentation/widgets/increace_and_decreace_widget.dart';
import 'package:svg_flutter/svg.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem});
  final CartItemEntity cartItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 92.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 92.h,
                      width: 73.w,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.lightGray,
                      ),
                      child: Image.network(
                        cartItem.product.imageUrl!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    17.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cartItem.product.name,
                          style: AppStyles.wight700Size13,
                        ),
                        Text(
                          '${cartItem.product.amount} ${cartItem.product.unitAmount}',
                          style: AppStyles.wight400Size13.copyWith(
                            color: AppColors.lightSecondary,
                          ),
                        ),
                        IncreaceAndDecreaceWidget(
                          count: cartItem.count,
                          onIncrease: cartItem.increasedCount,
                          onDecrease: cartItem.decreasedCount,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      splashColor: AppColors.green50,

                      onTap: () {},
                      child: SvgPicture.asset(AppAssets.assetsIconsTrash),
                    ),
                    Text(
                      ' ${cartItem.totalPrice} جنيه',
                      style: AppStyles.wight700Size16.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        3.width,
        Divider(color: AppColors.lightGray, thickness: 1),
        4.width,
      ],
    );
  }
}
