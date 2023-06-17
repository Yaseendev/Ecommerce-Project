import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'name.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final Name name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String avatarUrl;

  // final List<Address> addresses;
  // final List<Product> wishList;
  //final Cart? cart;

  User({
    this.id,
    required this.name,
    required this.email,
    this.avatarUrl = '',
    // this.addresses =const [],
    // this.wishList=const [],
    // this.cart,
  });

  @override
  List<Object?> get props => [id, name, email];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //'id': id,
      ...name.toMap(),
      'email': email,
      //'avatar': avatarUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: Name.fromMap(map),
      email: map['email'] as String,
      avatarUrl: map['profileImgUrl'] ?? '',
      // addresses: (map['addresses'] as List<dynamic>)
      //     .map((e) => Address.fromMap(e))
      //     .toList(),
      // wishList: (map['wishList'] as List<dynamic>)
      //     .map((e) => Product.fromMap(e))
      //     .toList(),
      // cart: map['cart'] == null
      //  ? Cart(cartContent: [], total: 0, subtotal: 0)
      //     : Cart.fromMap(map['cart']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    Name? name,
    String? email,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
