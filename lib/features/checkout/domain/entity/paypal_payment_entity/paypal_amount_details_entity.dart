import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';

class PayPalAmountDetailsEntity {
  final String subtotal;
  final String shipping;
  final int shippingDiscount;

  PayPalAmountDetailsEntity({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });
   factory PayPalAmountDetailsEntity.fromEntity( CheckoutEntity checkoutEntity) {
     return PayPalAmountDetailsEntity(
       subtotal: checkoutEntity.subTotal().toString(),
       shipping: checkoutEntity.shipping().toString(),
       shippingDiscount: checkoutEntity.discount().toInt(),

     );
   }
   Map<String, Object> toJson() => {
      'subtotal': subtotal,
      'shipping': shipping,
      'shipping_discount': shippingDiscount
      
   } ;
}
