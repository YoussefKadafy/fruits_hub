import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/row_text_widget.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
    required this.cart,
    this.address,
    this.isPayCash,
    required PageController pageController,
    this.selectedShippingIndex, this.onEditStep,
  }) ;
final void Function(int step)? onEditStep;
  final CartEntity cart;
  final AddressEntity? address;
  final bool? isPayCash;
  final int? selectedShippingIndex;

  @override
  Widget build(BuildContext context) {
    final price = cart.totalPrice(cart: cart);
    final deliveryFee = 30;
    final tax = 15;
    final total = price + deliveryFee + (isPayCash == true ? tax : 0);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ملخص الطلب :', style: AppStyles.wight700Size13),
          24.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.lightGrayWith50Opacity,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                RowTextWidget(
                  actionText: 'المجموع الفرعي',
                  resultText: "${price.toString()} جنيه",
                ),
                8.height,
                RowTextWidget(
                  actionText: 'التوصيل',
                  resultText: " $deliveryFee جنيه",
                  resultColor: AppColors.grayScale500,
                ),
                8.height,
                if (isPayCash == true)
                  RowTextWidget(
                    actionText: 'ضريبة',
                    resultText: ' $tax جنيه',
                    resultColor: AppColors.grayScale500,
                  ),
                if (isPayCash == true) 8.height,
                Divider(color: AppColors.grayScale),
                8.height,
                RowTextWidget(
                  actionText: 'المجموع الكلي',
                  resultText: '$total جنيه',
                  actionColor: AppColors.black,
                ),
              ],
            ),
          ),
          24.height,
          Text('طريقة الشحن :', style: AppStyles.wight700Size13),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.lightGrayWith50Opacity,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.local_shipping_outlined,
                          color: AppColors.primary),
                      8.width,
                      Expanded(
                      child: Text(
                          selectedShippingIndex == 0
                              ? 'الدفع عند الاستلام'
                              : 'الدفع عبر PayPal',
                          style: AppStyles.wight700Size13,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: AppColors.mintGreen,
                  ),
                  onPressed: () {
                      onEditStep?.call(1);

                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mode_edit,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      4.width,
                      Text(
                        'تعديل',
                        style: AppStyles.wight700Size13.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          24.height,
          Text('عنوان التوصيل :', style: AppStyles.wight700Size13),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.lightGrayWith50Opacity,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: AppColors.primary),
                      8.width,
                      Expanded(
                        child: Text(
                          address != null
                              ? '${address!.address}, ${address!.city}, ${address!.neighborhood}'
                              : 'لم يتم تحديد العنوان',
                          style: AppStyles.wight700Size13,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: AppColors.mintGreen,
                  ),
                  onPressed: () {
     onEditStep?.call(2);                 
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mode_edit,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      4.width,
                      Text(
                        'تعديل',
                        style: AppStyles.wight700Size13.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
