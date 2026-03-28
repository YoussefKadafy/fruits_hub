import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';

abstract class OrdersRepo {
  Future< Either<Failure, void> > addOrder({required CheckoutEntity checkoutEntity});
}