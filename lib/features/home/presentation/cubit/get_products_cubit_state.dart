part of 'get_products_cubit.dart';

abstract class GetProductsCubitState {}

class GetProductsCubitInitial extends GetProductsCubitState {}

class GetProductsCubitLoading extends GetProductsCubitState {}

class GetProductsCubitSuccess extends GetProductsCubitState {
  final List<ProductEntity> products;

  GetProductsCubitSuccess({required this.products});
}

class GetProductsCubitFailure extends GetProductsCubitState {
  final String errorMessage;

  GetProductsCubitFailure({required this.errorMessage});
}
