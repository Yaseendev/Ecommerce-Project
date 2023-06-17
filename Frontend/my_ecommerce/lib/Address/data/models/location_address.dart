import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationAddress extends Equatable{
  final LatLng location;
  final String name;
  final String street;
  final String area; //neighbourhood
  final String city;
  LocationAddress({
    required this.location,
    required this.name,
    required this.street,
    required this.area,
    required this.city,
  });

  LocationAddress copyWith({
    LatLng? location,
    String? name,
    String? street,
    String? area,
    String? city,
  }) {
    return LocationAddress(
      location: location ?? this.location,
      name: name ?? this.name,
      street: street ?? this.street,
      area: area ?? this.area,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //'location': location.toMap(),
      'name': name,
      'street': street,
      'area': area,
      'city': city,
    };
  }

  factory LocationAddress.fromMap(Map<String, dynamic> map) {
    return LocationAddress(
      location: LatLng(
        double.parse(map['lat']), double.parse(map['lon'])
      ),
      name: map['display_name'] ?? '',
      street: map['address']['road'] ?? '',
      area: map['address']['neighbourhood'] ?? '',
      city: map['address']['city'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationAddress.fromJson(String source) => LocationAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationAddres(location: $location, name: $name, street: $street, area: $area, city: $city)';
  }
  
  @override
  List<Object?> get props => [name, location, street, area, city];


}
