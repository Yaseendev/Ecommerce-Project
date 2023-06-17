import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 4)
class Category extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final String imgUrl;

  Category({
    required this.id,
    required this.name,
    required this.desc,
    required this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'imgUrl': imgUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      desc: map['desc'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [id, name, desc, imgUrl];
}
