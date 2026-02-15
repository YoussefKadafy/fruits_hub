import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_button.dart';
import 'package:fruits_hub/core/utils/custom_check_box.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';
import 'package:fruits_hub/features/add_product/presentation/cubit/add_product_cubit_cubit.dart';
import 'package:fruits_hub/features/add_product/presentation/widgets/add_image_field.dart';

class AddProductBody extends StatefulWidget {
  const AddProductBody({super.key});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  final ValueNotifier<bool> isFeaturedNotifier = ValueNotifier(false);
  final ValueNotifier<bool> isOrganicNotifier = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    isFeaturedNotifier.dispose();
    isOrganicNotifier.dispose();
    super.dispose();
  }

  late String productName, productCode, productDescription;
  late num productPrice;
  late int productQuantityOfKalories;
  late int productExpirationDate;
  File? productImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال اسم المنتج';
                  }
                  return null;
                },
              ),
              20.height,
              CustomTextField(
                hintText: 'سعر المنتج',
                labelText: 'سعر المنتج',
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  productPrice = num.tryParse(value!) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال سعر المنتج';
                  }
                  if (num.tryParse(value) == null) {
                    return 'الرجاء ادخال رقم صالح';
                  }
                  return null;
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال كود المنتج';
                  }
                  return null;
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال وصف المنتج';
                  }
                  return null;
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
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('منتج عضوي', style: AppStyles.onboardingSubTitle),
                  ValueListenableBuilder<bool>(
                    valueListenable: isOrganicNotifier,
                    builder: (context, isOrganic, _) {
                      return CustomCheckbox(
                        value: isOrganic,
                        onChanged: (value) {
                          isOrganicNotifier.value = value;
                        },
                      );
                    },
                  ),
                ],
              ),
              20.height,
              CustomTextField(
                hintText: 'عدد السعرات الحرارية',
                labelText: 'السعرات الحرارية',
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  productQuantityOfKalories = int.tryParse(value!) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال السعرات الحرارية';
                  }
                  if (int.tryParse(value) == null) {
                    return 'الرجاء ادخال رقم صالح';
                  }
                  return null;
                },
              ),
              20.height,
              CustomTextField(
                hintText: 'مدة الصلاحية (بالأشهر)',
                labelText: 'مدة الصلاحية',
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  productExpirationDate = int.tryParse(value!) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال مدة الصلاحية';
                  }
                  if (int.tryParse(value) == null) {
                    return 'الرجاء ادخال رقم صالح';
                  }
                  return null;
                },
              ),
              40.height,
              BlocConsumer<AddProductCubit, AddProductCubitState>(
                listener: (context, state) {
                  if (state is AddProductCubitFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                  } else if (state is AddProductCubitSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم اضافة المنتج بنجاح')),
                    );
                    // Reset form
                    _formKey.currentState!.reset();
                    setState(() {
                      productImage = null;
                    });
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AddProductCubitLoading;
                  return CustomButton(
                    text: isLoading
                        ? (state as AddProductCubitLoading).loadingMessage
                        : 'اضافة المنتج',
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () {
                            if (productImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('الرجاء اضافة صورة للمنتج'),
                                ),
                              );
                              return;
                            }

                            if (!_formKey.currentState!.validate()) {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                              return;
                            }

                            _formKey.currentState!.save();

                            final AddProductEntity input = AddProductEntity(
                              quantityOfKalories: productQuantityOfKalories,
                              isOrganic: isOrganicNotifier.value,
                              rating: 0,
                              reviews: 0,
                              name: productName,
                              description: productDescription,
                              price: productPrice,
                              image: productImage!,
                              code: productCode,
                              isFeatured: isFeaturedNotifier.value,
                              expiratinsDateByMonths: productExpirationDate,
                              reviewEntity: const [],
                            );
                            context.read<AddProductCubit>().addProduct(
                              addProductEntity: input,
                            );
                            // dispatch usecase / bloc / cubit
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
