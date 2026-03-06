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

class AddressInputSectionState extends State<AddressInputSection> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }


  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  AddressEntity? getAddress() {
    final fullName = _controllers['fullName']?.text;
    final address = _controllers['address']?.text;
    final city = _controllers['city']?.text;
    final neighborhood = _controllers['neighborhood']?.text;
    final phone = _controllers['phone']?.text;
    final floor = _controllers['floor']?.text;
    final apartment = _controllers['apartment']?.text;

    if (fullName == null || fullName.isEmpty ||
        address == null || address.isEmpty ||
        city == null || city.isEmpty ||
        neighborhood == null || neighborhood.isEmpty ||
        phone == null || phone.isEmpty) {
      return null;
    }

    return AddressEntity(
      name: fullName,
      phone: phone,
      address: address,
      city: city,
      neighborhood: neighborhood,
      floor: floor ?? '',
      apartment: apartment ?? '',
      buildingNumber: '',
    );
  }

  TextInputType _getKeyboardType(String hintText) {
    switch (hintText) {
      case 'رقم الهاتف':
        return TextInputType.phone;
      case 'العنوان':
        return TextInputType.streetAddress;
      case 'الاسم الكامل':
        return TextInputType.name;
      case 'المدينة':
      case 'الحي':
      default:
        return TextInputType.text;
    }
  }

  TextInputAction _getTextInputAction(String hintText, int index, int totalFields) {
    if (index == totalFields - 1) {
      return TextInputAction.done;
    }
    return TextInputAction.next;
  }

  String? _validateRequired(String? value, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال $fieldName';
    }
    return null;
  }

  // Helper to create validator with field name
  String? Function(String?) _getValidator(String fieldName) {
    return (value) => _validateRequired(value, fieldName: fieldName);
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
    ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
    
    final fields = [
      {'hintText': 'الاسم الكامل', 'labelText': 'الاسم الكامل', 'key': 'fullName', 'validator': _getValidator('الاسم الكامل')},
      {'hintText': 'العنوان', 'labelText': 'العنوان', 'key': 'address', 'validator': _getValidator('العنوان')},
      {'hintText': 'المدينة', 'labelText': 'المدينة', 'key': 'city', 'validator': _getValidator('المدينة')},
      {'hintText': 'الحي', 'labelText': 'الحي', 'key': 'neighborhood', 'validator': _getValidator('الحي')},
      {'hintText': 'رقم الهاتف', 'labelText': 'رقم الهاتف', 'key': 'phone', 'validator': _validatePhone},
    ];
    
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...fields.asMap().entries.map((entry) {
              final index = entry.key;
              final field = entry.value;
              final hintText = field['hintText'] as String;
              final labelText = field['labelText'] as String;
              final key = field['key'] as String;
              final validator = field['validator'] as String? Function(String?);
              
              _controllers[key] ??= TextEditingController();
              
              return Column(
                children: [
                  CustomTextField(
                    hintText: hintText,
                    labelText: labelText,
                    keyboardType: _getKeyboardType(hintText),
                    textInputAction: _getTextInputAction(hintText, index, fields.length + 1),
                    controller: _controllers[key],
                    validator: validator,
                  ),
                  16.height,
                ],
              );
            }),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: '٠١',
                    labelText: 'الطابق',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _controllers['floor'],
                  ),
                ),
                16.width,
                Expanded(
                  child: CustomTextField(
                    hintText: '٠١',
                    labelText: 'رقم الشقة',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _controllers['apartment'],
                  ),
                ),
              ],
            ),
            16.height,
            Row(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: isChecked,
                  builder: (context, value, child) => Switch(
                    value: value,
                    onChanged: (value) {
                      isChecked.value = value;
                    },
                    activeThumbColor: AppColors.primary,
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: AppColors.grayScale,
                  ),
                ),8.width,
                Text('حفظ المعلومات',style: AppStyles.wight600Size13.copyWith(color: AppColors.onboardingDescriptionTextColor),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
