import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  int count;
  CartItemEntity({required this.product, this.count = 1});
  num get totalPrice => product.price * count;
  num get totalAmount => product.amount * count;
  int decreasedCount() {
    if (count > 1) {
      return count - 1;
    } else {
      return count;
    }
  }

  int increasedCount() {
    return count + 1;
  }
}
