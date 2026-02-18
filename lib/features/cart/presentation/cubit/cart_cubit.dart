import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_Item_entity.dart';
import 'package:fruits_hub/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_hub/features/cart/presentation/cubit/cart_states.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  CartEntity cart = CartEntity(items: []);
  void addToCart({required CartItemEntity theCartItem}) {
    cart.addItem(theCartItem);
    emit(AddedToCartState());
  }
}
