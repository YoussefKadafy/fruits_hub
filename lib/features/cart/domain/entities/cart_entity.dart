import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;

  CartEntity({required this.items});
  void addItem(CartItemEntity item) {
    items.add(item);
  }

  num get totalPrice => items.fold(0, (total, item) => total + item.totalPrice);
}
