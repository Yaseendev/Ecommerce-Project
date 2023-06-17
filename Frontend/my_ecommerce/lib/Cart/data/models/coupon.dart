import 'dart:convert';

class Coupon {
  final String id;
  final String name;
  final String code;
  final num value;
  final bool valid;

  Coupon({
    required this.id,
    required this.name,
    required this.code,
    required this.value,
    required this.valid,
  });

  Coupon copyWith({
    String? id,
    String? name,
    String? code,
    num? value,
    bool? valid,
  }) {
    return Coupon(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      value: value ?? this.value,
      valid: valid ?? this.valid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'value': value,
      'valid': valid,
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      value: map['value'] as num,
      valid: map['valid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupon.fromJson(String source) =>
      Coupon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Coupon(id: $id, name: $name, code: $code, value: $value, valid: $valid)';
  }

}
