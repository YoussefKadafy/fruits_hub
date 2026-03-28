import 'package:fruits_hub/features/checkout/domain/entity/address_entity.dart';

class AddressModel {
  final String name;
  final String phone;
  final String address;
  final String city;
  final String  neighborhood;
  final String apartment;
  final String floor;
  final String buildingNumber;

  AddressModel({required this.name, required this.phone, required this.address, required this.city, required this.neighborhood, required this.apartment, required this.floor, required this.buildingNumber});
  factory AddressModel.fromEntity(AddressEntity addressEntity) {
    return AddressModel(
      name: addressEntity.name,
      phone: addressEntity.phone,
      address: addressEntity.address,
      city: addressEntity.city,
      neighborhood: addressEntity.neighborhood,
      apartment: addressEntity.apartment,
      floor: addressEntity.floor,
      buildingNumber: addressEntity.buildingNumber,
    );
    
  } 

  @override
  String toString() {

return '$address $city $neighborhood';  }
Map<String, String> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'neighborhood': neighborhood,
      'apartment': apartment,
      'floor': floor,
      'buildingNumber': buildingNumber,
    };
  }
}