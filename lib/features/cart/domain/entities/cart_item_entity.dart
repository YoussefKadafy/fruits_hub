import 'package:equatable/equatable.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  int count;
  CartItemEntity({required this.product, this.count = 1});
  num get totalPrice => product.price * count;
  num get totalAmount => product.amount * count;
  void decreaseCount() {
    if (count > 1) {
      count--;
    }
  }

  void increaseCount() {
    count++;
  }

  @override
  List<Object?> get props => [product];
}
