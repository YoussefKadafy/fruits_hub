import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';

class PayPalAmountDetailsEntity {
  final String subtotal;
  final String shipping;
final String shippingDiscount;

  PayPalAmountDetailsEntity({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });
   factory PayPalAmountDetailsEntity.fromEntity( CheckoutEntity checkoutEntity) {
     return PayPalAmountDetailsEntity(
subtotal: checkoutEntity.subTotal().toStringAsFixed(2),
shipping: checkoutEntity.shipping().toStringAsFixed(2),
shippingDiscount: checkoutEntity.discount().toStringAsFixed(2),
     );
   }
   Map<String, Object> toJson() => {
      'subtotal': subtotal,
      'shipping': shipping,
      'shipping_discount': shippingDiscount
      
   } ;
}
