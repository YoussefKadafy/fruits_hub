import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';

class AddressInputSection extends StatelessWidget {
  const AddressInputSection({super.key});


  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(children: [
        CustomTextField(
           hintText: 'الاسم الكامل',
        ),
        16.height,
        CustomTextField(
          hintText: 'العنوان',
        ),
        16.height,
        
       CustomTextField(
            hintText:  'المدينة'
          ) ,
           16.height,
      CustomTextField(
            hintText:  'الحي'
          ) ,
           16.height,
          CustomTextField(
            hintText:  'الطابق . رقم الشقة'
       ), 
           16.height,
          
             CustomTextField(
          hintText: 'رقم الهاتف',),
           16.height,
         Row(children: [           ValueListenableBuilder<bool>(valueListenable: isChecked, builder: (context, value, child) => 
          Switch(value:  value, onChanged: (value){
            isChecked.value = value;
          },
            activeThumbColor: AppColors.primary  ,
            thumbColor: WidgetStateProperty.all(Colors.white),
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.grayScale,
             
              
           
           
           
              
           
           ),)
         
           ,
            Text('حفظ المعلومات'),
         ],)
        ]),
    );
  }
}
