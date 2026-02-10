import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/core/utils/custom_check_box.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';
import 'package:fruits_hub/features/add_product/presentation/widgets/add_image_field.dart';

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  final ValueNotifier<bool> isFeaturedNotifier = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    isFeaturedNotifier.dispose();
    super.dispose();
  }

  late String productName, productCode, productDescription;
  late num productPrice;
  File? productImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              CustomTextField(
                hintText: 'اسم المنتج',
                labelText: 'اسم المنتج',
                keyboardType: TextInputType.name,
                onSaved: (value) {
                  productName = value!;
                },
              ),
              20.height,
              CustomTextField(
                hintText: 'سعر المنتج',
                labelText: 'سعر المنتج',
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  productPrice = num.parse(value!);
                },
              ),
              20.height,
              CustomTextField(
                hintText: 'كود المنتج',
                labelText: 'كود المنتج',
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  productCode = value!.toLowerCase();
                },
              ),
              20.height,
              CustomTextField(
                hintText: 'وصف المنتج',
                labelText: 'وصف المنتج',
                keyboardType: TextInputType.text,
                maxLines: 5,
                onSaved: (value) {
                  productDescription = value!;
                },
              ),
              20.height,
              AddImageField(
                onImageAdded: (image) {
                  productImage = image;
                },
              ),
              20.height,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الانتقاء كمنتج مميز',
                    style: AppStyles.onboardingSubTitle,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: isFeaturedNotifier,
                    builder: (context, isFeatured, _) {
                      return CustomCheckbox(
                        value: isFeatured,
                        onChanged: (value) {
                          isFeaturedNotifier.value = value;
                        },
                      );
                    },
                  ),
                ],
              ),
              40.height,
              CustomButton(
                text: 'اضافة المنتج',
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                onPressed: () {
                  if (productImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إضافة صورة للمنتج')),
                    );
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
