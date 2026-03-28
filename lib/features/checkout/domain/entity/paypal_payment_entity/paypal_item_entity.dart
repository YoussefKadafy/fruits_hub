import 'package:fruits_hub/core/helpers/get_currency.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_item_entity.dart';

class PayPalItemEntity {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  PayPalItemEntity({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  factory PayPalItemEntity.fromEntity(CartItemEntity cartItemEntity) {
    return PayPalItemEntity(
       name: cartItemEntity.product.name,
       quantity: cartItemEntity.count,
       price: cartItemEntity.product.price.toString(),
       currency: getCurrency(),
    );
  }
  Map<String, Object> toJson() => {
     'name': name,
     'quantity': quantity,
     'price': price,
     'currency': currency
  };
  
}
