import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/app_styles/app_assets.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';
import 'package:fruits_hub/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fruits_hub/features/cart/presentation/widgets/increace_and_decreace_widget.dart';
import 'package:svg_flutter/svg.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartItem, required this.totalPrice});
  final CartItemEntity cartItem;
  final num totalPrice;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
                        widget.cartItem.product.imageUrl!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    17.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.cartItem.product.name,
                          style: AppStyles.wight700Size13,
                        ),
                        Text(
                          '${widget.cartItem.product.amount} ${widget.cartItem.product.unitAmount}',
                          style: AppStyles.wight400Size13.copyWith(
                            color: AppColors.lightSecondary,
                          ),
                        ),
                        IncreaceAndDecreaceWidget(
                          count: widget.cartItem.count,
                          onIncrease: () {
                            context.read<CartCubit>().increaseItemCount(
                              widget.cartItem,
                            );
                          },
                          onDecrease: () {
                            context.read<CartCubit>().decreaseItemCount(
                              widget.cartItem,
                            );
                          },
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

                      onTap: () {
                        context.read<CartCubit>().removeFromCart(
                          cartItem: widget.cartItem,
                        );
                      },
                      child: SvgPicture.asset(AppAssets.assetsIconsTrash),
                    ),
                    Text(
                      ' ${widget.cartItem.totalPrice} جنيه',
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
