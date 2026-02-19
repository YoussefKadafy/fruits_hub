import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;

  CartEntity({required this.items});
  void addItem(CartItemEntity item) {
    items.add(item);
  }

  void removeItem(CartItemEntity item) {
    items.remove(item);
  }

  bool isItemInCart(ProductEntity product) {
    return items.any((item) => item.product.code == product.code);
  }

  CartItemEntity? getCartItemByProduct(ProductEntity product) {
    for (var item in items) {
      if (item.product.code == product.code) {
        return item;
      }
    }
    return null;
  }

  num totalPrice({required CartEntity cart}) {
    num total = 0;
    for (var item in items) {
      total += item.product.price * item.count;
    }
    return total;
  }
}
