import 'package:fruits_hub/features/cart/domain/entities/cart_item_entity.dart';

class OrderProductModel {
  final String name;
  final String price;
  final String imageUrl;
  final String code;
  final String quantity;

  OrderProductModel({required this.name, required this.price, required this.imageUrl, required this.code, required this.quantity});
  factory OrderProductModel.fromEntity(CartItemEntity item) {
    return OrderProductModel(
      name: item.product.name,
      price: item.product.price.toString(),
      imageUrl: item.product.imageUrl!,
      code: item.product.code,
      quantity: item.count.toString(),
    );
    
  }
  Map<String, String> toJson() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'code': code,
      'quantity': quantity,
    };
  }
}