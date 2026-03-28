import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruits_hub/core/app_styles/app_colors.dart';
import 'package:fruits_hub/core/app_styles/app_styles.dart';
import 'package:fruits_hub/core/extensions/sized_box_extension.dart';
import 'package:fruits_hub/core/utils/custom_text_field.dart';
import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';

class AddressInputSection extends StatefulWidget {
  const AddressInputSection({super.key});

  @override
  AddressInputSectionState createState() => AddressInputSectionState();
}

class AddressInputSectionState extends State<AddressInputSection> with AutomaticKeepAliveClientMixin  {
  final _formKey = GlobalKey<FormState>();
  
  final _fullNameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _neighborhoodFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _floorFocusNode = FocusNode();
  final _apartmentFocusNode = FocusNode();
  
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _phoneController = TextEditingController();
  final _floorController = TextEditingController();
  final _apartmentController = TextEditingController();
  
  bool _saveInfo = false;

  @override
  void dispose() {
    _fullNameFocusNode.dispose();
    _addressFocusNode.dispose();
    _cityFocusNode.dispose();
    _neighborhoodFocusNode.dispose();
    _phoneFocusNode.dispose();
    _floorFocusNode.dispose();
    _apartmentFocusNode.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _neighborhoodController.dispose();
    _phoneController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  AddressEntity? getAddress() {
    final fullName = _fullNameController.text.trim();
    final address = _addressController.text.trim();
    final city = _cityController.text.trim();
    final neighborhood = _neighborhoodController.text.trim();
    final phone = _phoneController.text.trim();
    final floor = _floorController.text.trim();
    final apartment = _apartmentController.text.trim();

    if (fullName.isEmpty ||
        address.isEmpty ||
        city.isEmpty ||
        neighborhood.isEmpty ||
        phone.isEmpty) {
      return null;
    }

    return AddressEntity(
      name: fullName,
      phone: phone,
      address: address,
      city: city,
      neighborhood: neighborhood,
      floor: floor,
      apartment: apartment,
      buildingNumber: '',
    );
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال $fieldName';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }
    if (value.length < 11) {
      return 'رقم الهاتف يجب أن يكون 11 رقم على الأقل';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'معلومات العنوان',
                style: AppStyles.wight600Size18.copyWith(
                  color: AppColors.onboardingDescriptionTextColor,
                ),
              ),
              16.height,
              
              CustomTextField(
                focusNode: _fullNameFocusNode,
                hintText: 'الاسم الكامل',
                labelText: 'الاسم الكامل',
                controller: _fullNameController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_addressFocusNode),
                validator: (v) => _validateRequired(v, 'الاسم الكامل'),
              ),
              16.height,
              
              CustomTextField(
                focusNode: _addressFocusNode,
                hintText: 'العنوان',
                labelText: 'العنوان',
                controller: _addressController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_cityFocusNode),
                validator: (v) => _validateRequired(v, 'العنوان'),
              ),
              16.height,
              
              CustomTextField(
                focusNode: _cityFocusNode,
                hintText: 'المدينة',
                labelText: 'المدينة',
                controller: _cityController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_neighborhoodFocusNode),
                validator: (v) => _validateRequired(v, 'المدينة'),
              ),
              16.height,
              
              CustomTextField(
                focusNode: _neighborhoodFocusNode,
                hintText: 'الحي',
                labelText: 'الحي',
                controller: _neighborhoodController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneFocusNode),
                validator: (v) => _validateRequired(v, 'الحي'),
              ),
              16.height,
              
              CustomTextField(
                focusNode: _phoneFocusNode,
                hintText: 'رقم الهاتف',
                labelText: 'رقم الهاتف',
                controller: _phoneController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_floorFocusNode),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              24.height,
              
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      focusNode: _floorFocusNode,
                      hintText: '٠١',
                      labelText: 'الطابق',
                      controller: _floorController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_apartmentFocusNode),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: CustomTextField(
                      focusNode: _apartmentFocusNode,
                      hintText: '٠١',
                      labelText: 'رقم الشقة',
                      controller: _apartmentController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              24.height,
              
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.grayScale.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Switch(
                      value: _saveInfo,
                      onChanged: (value) => setState(() => _saveInfo = value),
                      activeThumbColor: AppColors.primary,
                      thumbColor: WidgetStateProperty.all(Colors.white),
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.grayScale,
                    ),
                    8.width,
                    Expanded(
                      child: Text(
                        'حفظ المعلومات لاستخدامها لاحقاً',
                        style: AppStyles.wight600Size13.copyWith(
                          color: AppColors.onboardingDescriptionTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              24.height,
            ],
          ),
        ),
      ),
    );
  }
  
  @override
bool get wantKeepAlive => true;}
