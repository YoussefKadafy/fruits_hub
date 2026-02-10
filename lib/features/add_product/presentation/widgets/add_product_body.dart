import 'package:flutter/material.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';
import 'package:fruits_hub/features/add_product/presentation/widgets/add_image_field.dart';

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            20.height,
            CustomTextField(
              hintText: 'اسم المنتج',
              labelText: 'اسم المنتج',
              keyboardType: TextInputType.name,
            ),
            20.height,
            CustomTextField(
              hintText: 'سعر المنتج',
              labelText: 'سعر المنتج',
              keyboardType: TextInputType.number,
            ),
            20.height,
            CustomTextField(
              hintText: 'وصف المنتج',
              labelText: 'وصف المنتج',
              keyboardType: TextInputType.text,
              maxLines: 5,
            ),
            20.height,
            AddImageField(onImageAdded: (image) {}),
          ],
        ),
      ),
    );
  }
}
