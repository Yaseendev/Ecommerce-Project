import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'name.g.dart';

@HiveType(typeId: 1)
class Name extends Equatable {
  @HiveField(0)
  final String first;

  @HiveField(1)
  final String last;

  Name({
    required this.first,
    required this.last,
  });
  
  @override
  List<Object?> get props => [first, last];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': first,
      'lastName': last,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      first: map['firstName'] ?? '',
      last: map['lastName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) => Name.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '$first $last';
}
