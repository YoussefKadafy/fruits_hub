import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entity/paypal_payment_entity/paypal_amount_details_entity.dart';

class PayPalAmountEntity {
  final String total;
  final String currency;
  final PayPalAmountDetailsEntity details;

  PayPalAmountEntity({
    required this.total,
    required this.currency,
    required this.details,
  });

  factory PayPalAmountEntity.fromEntity( CheckoutEntity checkoutEntity){

    return PayPalAmountEntity(
      total: checkoutEntity.total().toString(),
      currency: 'USD',
      details: PayPalAmountDetailsEntity.fromEntity(checkoutEntity)
    );
  }
  Map<String, Object> toJson() => {
    'total': total,
    'currency': currency,
    'details': details.toJson()
  };
}
