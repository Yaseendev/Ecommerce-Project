import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address extends Equatable {
  final LatLng position;
  final String city;
  final String street;
  final String blockNumber;
  final String? floorNumber;
  final String phone;
  final String buildingName;
  final String? apartmentNumber;
  final String? additionalInfo;
  final String? label;

  Address({
    required this.position,
    required this.city,
    required this.street,
     this.blockNumber = '',
    this.floorNumber,
    required this.phone,
    required this.buildingName,
     this.apartmentNumber,
     this.additionalInfo,
     this.label,
  });

  Address copyWith({
    LatLng? position,
    String? city,
    String? street,
    String? blockNumber,
    String? floorNumber,
    String? phone,
    String? buildingName,
    String? apartmentNumber,
    String? additionalInfo,
    String? label,
  }) {
    return Address(
      position: position ?? this.position,
      city: city ?? this.city,
      street: street ?? this.street,
      blockNumber: blockNumber ?? this.blockNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      phone: phone ?? this.phone,
      buildingName: buildingName ?? this.buildingName,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
      'city': city,
      'street': street,
      'blockNumber': blockNumber,
      'floorNumber': floorNumber,
      'phone': phone,
      'buildingName': buildingName,
      'apartmentNumber': apartmentNumber,
      'additionalInfo': additionalInfo,
      'label': label,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      position: LatLng(
        map['position']['latitude'], 
        map['position']['longitude'],
      ),
      city: map['city'] ?? '',
      street: map['street'] ?? '',
      blockNumber: map['blockNumber'] ?? '',
      floorNumber: map['floorNumber'] != null ? map['floorNumber'] as String : '',
      phone: map['phone'] ?? '',
      buildingName: map['buildingName'] ?? '',
      apartmentNumber: map['apartmentNumber'] != null ? map['apartmentNumber'] as String : '',
      additionalInfo: map['additionalInfo'] != null ? map['additionalInfo'] as String : '',
      label: map['label'] != null ? map['label'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$street, $city';
  }

  @override
  List<Object?> get props {
    return [
      position,
      city,
      street,
      blockNumber,
      floorNumber,
      phone,
      buildingName,
      apartmentNumber,
      additionalInfo,
      label,
    ];
  }

  @override
  bool get stringify => true;
}
