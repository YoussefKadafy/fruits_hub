import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruits_hub/core/repos/orders_repo/orders_repo.dart';
import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({required this.ordersRepo}) : super(OrdersInitial());
  final OrdersRepo ordersRepo;
  Future <void> addOrder({required CheckoutEntity checkoutEntity}) async {

    emit(OrdersLoading());
    final result = await ordersRepo.addOrder(checkoutEntity: checkoutEntity);
    result.fold((l) => emit(OrdersFailure(message: l.message)), (r) => emit(OrdersSuccess()));
    
  }
}
