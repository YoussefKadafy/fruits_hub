import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';

class CheckoutEntity {
  final AddressEntity? address;
  final CartEntity   cartItems;
  final bool? isPayCash;

  CheckoutEntity({ this.address, required this.cartItems,  this.isPayCash});
  
}