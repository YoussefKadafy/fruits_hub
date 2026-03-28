import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/helpers/backend_endpoints.dart';
import 'package:fruits_hub/core/repos/orders_repo/orders_repo.dart';
import 'package:fruits_hub/core/services/data_base_service.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';
import 'package:fruits_hub/features/checkout/domain/entity/checkout_entity.dart';

class OrdersRepoImpl implements OrdersRepo{
   final DataBaseService dataBaseService;

  OrdersRepoImpl({required this.dataBaseService});
  @override
  Future<Either<Failure, void>> addOrder({required CheckoutEntity checkoutEntity}) async{

    try {

await dataBaseService.addData(path: BackendEndpoints.ordersCollection, data:  OrderModel.fromEntity( checkoutEntity).toJson());

      return Right(null);
      
    } catch (e) {

      return Left(ServerFailure(e.toString()));
      
    }
  }
}