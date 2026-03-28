import 'package:fruits_hub/features/checkout/data/models/address_model.dart';
import 'package:fruits_hub/features/checkout/data/models/order_product_model.dart';
import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';

class OrderModel {
  final String paymentMethod, uId;
  final double totalPrice;
  final AddressModel address;
  final List<OrderProductModel> orderProducts;

  OrderModel({
    required this.uId,
    required this.totalPrice,
    required this.address,
    required this.orderProducts,
    required this.paymentMethod,
  });
  factory OrderModel.fromEntity(CheckoutEntity entity) {
    return OrderModel(
      uId: entity.uId,
      totalPrice: entity.cartItems
          .totalPrice(cart: entity.cartItems)
          .toDouble(),
      address: AddressModel.fromEntity(entity.address!),
      orderProducts: entity.cartItems.items
          .map((e) => OrderProductModel.fromEntity(e))
          .toList(),
      paymentMethod: entity.isPayCash! ? 'Cash' : 'PayPal',
    );
  }
  Map<String, Object> toJson() {
    return {
      'uId': uId,
      'totalPrice': totalPrice,
      'address': address.toJson(),
      'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
      'paymentMethod': paymentMethod,
    };
  }
}
