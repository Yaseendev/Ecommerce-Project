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

  String toJson() => json.encode(toMap());
}
