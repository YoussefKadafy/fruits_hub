part of 'add_product_cubit_cubit.dart';

@immutable
abstract class AddProductCubitState {}

class AddProductCubitInitial extends AddProductCubitState {}

class AddProductCubitLoading extends AddProductCubitState {}

class AddProductCubitSuccess extends AddProductCubitState {}

class AddProductCubitFailure extends AddProductCubitState {
  final String errorMessage;

  AddProductCubitFailure({required this.errorMessage});
}
