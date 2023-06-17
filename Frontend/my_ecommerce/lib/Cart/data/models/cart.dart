import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'cart_item.dart';
import 'coupon.dart';

part 'cart.g.dart';

@HiveType(typeId: 5)
class Cart {
  @HiveField(0)
  final List<CartItem> cartContent;
  @HiveField(1)
  final double total;
  @HiveField(2)
  final double subtotal;
  final Coupon? coupon;

  Cart({
    required this.cartContent,
    required this.total,
    required this.subtotal,
    this.coupon,
  });

  Cart copyWith({
    List<CartItem>? cartContent,
    double? total,
    double? subtotal,
    Coupon? coupon,
  }) {
    return Cart(
      cartContent: cartContent ?? this.cartContent,
      total: total ?? this.total,
      subtotal: subtotal ?? this.subtotal,
      coupon: coupon ?? this.coupon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartContent': cartContent.map((e) => e.toMapForAdd()).toList(),
      'total': total,
      'subtotal': subtotal,
      if(coupon != null) 'coupon': coupon?.toMap(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartContent: (map['cartContent'] as List<dynamic>)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      total: double.parse(map['total'].toString()),
      subtotal: double.parse(map['subtotal'].toString()),
      coupon: map['coupon'] == null
          ? null
          : Coupon.fromMap(map['coupon']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(cartContent: $cartContent, total: $total, subtotal: $subtotal)';
  }
}
