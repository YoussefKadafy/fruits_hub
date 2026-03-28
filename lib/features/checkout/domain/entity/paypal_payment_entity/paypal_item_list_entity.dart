import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/paypal_payment_entity/paypal_item_entity.dart';

class PayPalItemListEntity {
  final List<PayPalItemEntity> items;

  PayPalItemListEntity({
    required this.items,
  });

factory PayPalItemListEntity.fromEntity(CartEntity cart) {
  List<PayPalItemEntity> items = [];
  for (var item in cart.items) {
    items.add(PayPalItemEntity.fromEntity(item));
  }
  return PayPalItemListEntity(items: items);
  
}
  Map<String, Object> toJson() => {
    'items': items.map((item) => item.toJson()).toList()
  };
}
