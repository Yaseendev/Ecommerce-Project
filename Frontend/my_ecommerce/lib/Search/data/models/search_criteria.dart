import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Utils/enums.dart';

class SearchCriteria {
  final Set<Category> selectedCategories;
  double? startPrice;
  double? endPrice;
  RangeValues? ratingRange;
  SortOptions? selectedSort;
  final Set<String> selectedBrands;
  
  SearchCriteria({
    required this.selectedCategories,
    this.startPrice,
    this.endPrice,
    this.ratingRange,
    this.selectedSort,
    required this.selectedBrands,
  });

  SearchCriteria copyWith({
    Set<Category>? selectedCategories,
    double? startPrice,
    double? endPrice,
    RangeValues? ratingRange,
    SortOptions? selectedSort,
    Set<String>? selectedBrands,
  }) {
    return SearchCriteria(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      startPrice: startPrice ?? this.startPrice,
      endPrice: endPrice ?? this.endPrice,
      ratingRange: ratingRange ?? this.ratingRange,
      selectedSort: selectedSort ?? this.selectedSort,
      selectedBrands: selectedBrands ?? this.selectedBrands,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
     if(selectedCategories.isNotEmpty) 'categoryIds': selectedCategories.map((x) => x.id).toList().join(','),
     if(startPrice != null) 'startPrice': startPrice,
      if(endPrice != null) 'endPrice': endPrice,
      if(ratingRange != null) 'startRating': ratingRange?.start,
      if(ratingRange != null) 'endRating': ratingRange?.end,
      if(selectedSort != null) 'sort': selectedSort?.name,
      if(selectedBrands.isNotEmpty) 'brands': selectedBrands.join(','),
    };
  }

  // factory SearchCriteria.fromMap(Map<String, dynamic> map) {
  //   return SearchCriteria(
  //     selectedCategories: Set<Category>.from((map['categoryIds'] as List<int>).map<Category>((x) => Category.fromMap(x as Map<String,dynamic>),),),
  //     startPrice: map['startPrice'] != null ? map['startPrice'] as double : null,
  //     endPrice: map['endPrice'] != null ? map['endPrice'] as double : null,
  //     ratingRange: map['ratingRange'] != null ? RangeValues.fromMap(map['ratingRange'] as Map<String,dynamic>) : null,
  //     selectedSort: map['selectedSort'] != null ? SortOptions.fromMap(map['selectedSort'] as Map<String,dynamic>) : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  //factory SearchCriteria.fromJson(String source) => SearchCriteria.fromMap(json.decode(source) as Map<String, dynamic>);
}
