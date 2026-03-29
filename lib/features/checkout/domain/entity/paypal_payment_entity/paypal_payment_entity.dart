import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/paypal_payment_entity/paypal_amount_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/paypal_payment_entity/paypal_item_list_entity.dart';

class PayPalPaymentEntity {
  final PayPalAmountEntity amount;
  final String description;
  final PayPalItemListEntity itemList;

  PayPalPaymentEntity({
    required this.amount,
    required this.description,
    required this.itemList,
  });
  factory PayPalPaymentEntity.fromEntity(CheckoutEntity entity) =>
      PayPalPaymentEntity(
        amount: PayPalAmountEntity.fromEntity(entity),
        description: 'Payment with Paypal from FruitsHub',
        itemList: PayPalItemListEntity.fromEntity(entity.cartItems),
      );
  Map<String, Object> toJson() => {
    'amount': amount.toJson(),
    'description': description,
'item_list': itemList.toJson(),
  };
}
