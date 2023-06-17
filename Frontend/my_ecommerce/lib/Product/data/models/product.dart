import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';

part 'product.g.dart';

@HiveType(typeId: 3)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final num price;
  @HiveField(3)
  final List<String> images;
  @HiveField(4)
  final num? salePercentage;
  @HiveField(5)
  final num? salePrice;
  @HiveField(6)
  final String desc;
  @HiveField(7)
  final bool isFav;
  @HiveField(8)
  final String brand;
  @HiveField(9)
  final String thumbnail;
  @HiveField(10)
  final Category category;
  @HiveField(11)
  final double rating;
  //@HiveField(12)
  final String link;
  // @HiveField(13)
  // final num finalPrice;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.images = const [],
    this.salePercentage,
    this.salePrice,
    this.desc = '',
    this.isFav = false,
    required this.brand,
    this.thumbnail = '',
    required this.category,
    required this.rating,
    this.link = '',
  });

  Product copyWith({
    String? id,
    String? name,
    num? price,
    List<String>? images,
    num? salePercentage,
    num? salePrice,
    num? regularPrice,
    String? desc,
    bool? isFav,
    String? brand,
    String? thumbnail,
    Category? category,
    double? rating,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      images: images ?? this.images,
      salePercentage: salePercentage ?? this.salePercentage,
      salePrice: salePrice ?? this.salePrice,
      desc: desc ?? this.desc,
      isFav: isFav ?? this.isFav,
      brand: brand ?? this.brand,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': name,
      'price': price,
      'images': images,
      'discountPercentage': salePercentage,
      'finalPrice': salePrice,
      'description': desc,
      'brand': brand,
      'thumbnail': thumbnail,
      'category': category.toMap(),
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['title'] ?? '',
      price: map['price'] as num,
      images: List<String>.from((map['images'])),
      salePercentage: map['discountPercentage'] != null
          ? map['discountPercentage'] as num
          : null,
      salePrice: map['finalPrice'],
      // map['discountPercentage'] != null
      //     ? (map['price'] - (map['price'] * (map['discountPercentage'] / 100)))
      //     : null,
      //regularPrice: map['regularPrice'] as num,
      desc: map['description'] ?? '',
      //isFav: map['isFav'] as bool,
      brand: map['brand'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      category: Category.fromMap(map['category']),
      rating: map['rating'],
      link: map['link'] ?? '',
    );
  }

  // double? get getTotalRating {
  //   const num initval = 0;

  //   return (ratings != null
  //           ? ratings!.fold(
  //               initval,
  //               (previousValue, element) =>
  //                   element.rating + double.parse(previousValue.toString()))
  //           : 0) /
  //       (ratings != null && ratings!.isNotEmpty ? ratings!.length : 1);
  // }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, images: $images, salePercentage: $salePercentage, salePrice: $salePrice, desc: $desc, isFav: $isFav, brand: $brand, thumbnail: $thumbnail)';
  }

  @override
  List<Object?> get props => [id, name];
}
