// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

enum SortOptions {
  most_relv(title: 'Most Relevant'),
  low_price(title: 'Lowest Price'),
  high_price(title: 'Highest Price'),
  high_rating(title: 'Highest Rating'),
  low_rating(title: 'Lowest Rating');

  final String title;
  const SortOptions({
    required this.title,
  });

  factory SortOptions.fromString(String option) {
    switch (option) {
      case 'most_relv':
        return SortOptions.most_relv;
      case 'low_price':
        return SortOptions.low_price;
      case 'high_price':
        return SortOptions.high_price;
      case 'high_rating':
        return SortOptions.high_rating;
      case 'low_rating':
        return SortOptions.low_rating;
      default:
        return SortOptions.most_relv;
    }
  }
}

enum OrderStatus {
  PLACED(
    label: 'Placed',
    value: 'PLACED',
  ),
  REVIEW(
    label: 'Review',
    value: 'REVIEW',
  ),
  ACCEPTED(
    label: 'Accepted',
    value: 'ACCEPTED',
  ),
  REJECTED(
    label: 'Rejected',
    value: 'REJECTED',
    color: Colors.red,
  ),
  CANCELED(
    label: 'Canceled',
    value: 'CANCELED',
    color: Colors.red,
  ),
  PREPARING(
    label: 'Packing',
    value: 'PREPARING',
    color: Colors.orange,
  ),
  DELIVERING(
    label: 'Delivering',
    value: 'DELIVERING',
    color: Colors.orange,
  ),
  DELIVERED(
    label: 'Delivered',
    value: 'DELIVERED',
    color: Colors.green,
  ),
  UNKNOWN(
    label: 'Unkown',
    value: 'UNKNOWN',
  );

  final String label;
  final String value;
  final Color? color;
  const OrderStatus({
    required this.label,
    required this.value,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': value,
    };
  }

  factory OrderStatus.fromMap(Map<String, dynamic> map) {
    final String orderStat = map['status'] ?? '';
    switch (orderStat) {
      case 'PLACED':
        return OrderStatus.PLACED;
      case 'REVIEW':
        return OrderStatus.REVIEW;
      case 'ACCEPTED':
        return OrderStatus.ACCEPTED;
      case 'REJECTED':
        return OrderStatus.REJECTED;
      case 'CANCELED':
        return OrderStatus.CANCELED;
      case 'PREPARING':
        return OrderStatus.PREPARING;
      case 'DELIVERING':
        return OrderStatus.DELIVERING;
      case 'DELIVERED':
        return OrderStatus.DELIVERED;
      default:
        return OrderStatus.UNKNOWN;
    }
  }

  String toJson() => json.encode(toMap());

  factory OrderStatus.fromJson(String source) =>
      OrderStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum PaymentMethod {
  cash(
    label: 'Cash',
    value: 'CASH',
  ),
  creditCard(
    value: 'CREDIT_CARD',
    label: 'Credit Card',
  ),
  paypal(
    label: 'PayPal',
    value: 'PAYPAL',
  ),
  unknown(
    label: 'Unknown',
    value: 'UNKNOWN',
  );

  final String label;
  final String value;
  const PaymentMethod({
    required this.label,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paymentMethod': value,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    final String orderStat = map['paymentMethod'] ?? '';
    switch (orderStat) {
      case 'CASH':
        return PaymentMethod.cash;
      case 'CREDIT_CARD':
        return PaymentMethod.creditCard;
      case 'PAYPAL':
        return PaymentMethod.paypal;
      default:
        return PaymentMethod.unknown;
    }
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum ViewType { grid, List }
