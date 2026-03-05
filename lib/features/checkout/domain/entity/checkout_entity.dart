import 'package:fruits_hub/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';

class CheckoutEntity {
  final AddressEntity address;
  final List<CartItemEntity> cartItems;
  final bool isPayCash;

  CheckoutEntity({required this.address, required this.cartItems, required this.isPayCash});
  
}