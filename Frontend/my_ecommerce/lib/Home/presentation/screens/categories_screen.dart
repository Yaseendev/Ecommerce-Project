import 'package:flutter/material.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Utils/constants.dart';

import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories;
  const CategoriesScreen({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Categories',
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        leading: BackButton(
          color: AppColors.PRIMARY_COLOR,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
          );
        },
      ),
    );
  }
}
