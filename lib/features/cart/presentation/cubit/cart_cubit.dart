import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/cart/presentation/cubit/cart_states.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  CartEntity cart = CartEntity(items: []);
  num get totalPrice => cart.totalPrice(cart: cart);
  void addToCart({required ProductEntity productEntity}) {
    bool isInCart = cart.isItemInCart(productEntity);
    if (isInCart) {
      var cartItem = cart.getCartItemByProduct(productEntity);
      cartItem!.count = cartItem.count + 1;
    } else {
      var newCartItem = CartItemEntity(product: productEntity);
      cart.addItem(newCartItem);
    }
    emit(AddedToCartState());
  }

  void removeFromCart({required CartItemEntity cartItem}) {
    cart.removeItem(cartItem);
    emit(RemovedFromCartState());
  }

  void increaseItemCount(CartItemEntity cartItem) {
    cartItem.increaseCount();
    emit(AddedToCartState());
  }

  void decreaseItemCount(CartItemEntity cartItem) {
    cartItem.decreaseCount();
    emit(AddedToCartState());
  }
}
