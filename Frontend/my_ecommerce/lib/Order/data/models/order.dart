import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Address/data/models/address.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Utils/enums.dart';

class Order extends Equatable {
  final String? id;
  final OrderStatus? status;
  final Cart cart;
  final Address address;
  final String notes;
  final PaymentMethod paymentMethod;
  final DateTime? orderedAt;

  Order({
    this.id,
    this.status,
    required this.cart,
    required this.address,
    required this.notes,
    required this.paymentMethod,
     this.orderedAt,
  });

  Order copyWith({
    String? id,
    OrderStatus? status,
    Cart? cart,
    Address? address,
    String? notes,
    PaymentMethod? paymentMethod,
    DateTime? orderedAt,
  }) {
    return Order(
      id: id ?? this.id,
      status: status ?? this.status,
      cart: cart ?? this.cart,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderedAt: orderedAt ?? this.orderedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(id != null) 'id': id,
      if(status != null) 'status': status?.toMap(),
      'cart': cart.toMap(),
      'address': address.toMap(),
      'notes': notes,
      'paymentMethod': paymentMethod.value,
      //'orderedAt': orderedAt.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as String : null,
      status: map['status'] != null ? OrderStatus.fromMap(map) : null,
      cart: Cart.fromMap(map['cart'] as Map<String,dynamic>),
      address: Address.fromMap(map['address'] as Map<String,dynamic>),
      notes: map['notes'] ?? '',
      paymentMethod: PaymentMethod.fromMap(map),
      orderedAt: DateTime.tryParse(map['orderDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, status: $status, cart: $cart, address: $address, notes: $notes)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      status,
      cart,
      address,
      notes,
      paymentMethod,
      orderedAt,
    ];
  }
}
