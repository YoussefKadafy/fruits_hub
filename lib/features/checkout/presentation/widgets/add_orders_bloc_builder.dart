import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/checkout/presentation/cubits/orders_cubit/orders_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddOrdersBlocBuilder extends StatelessWidget {
  const AddOrdersBlocBuilder({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
return BlocConsumer<OrdersCubit, OrdersState>(
   
  builder: (context, state ){

  return ModalProgressHUD( inAsyncCall:state is  OrdersLoading ,child: child);
}, listener:  (context, state) {
  if(state is  OrdersFailure){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
  } 
   else if(state is  OrdersSuccess){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم اضافة الطلب بنجاح' )));
  }

});  }
}