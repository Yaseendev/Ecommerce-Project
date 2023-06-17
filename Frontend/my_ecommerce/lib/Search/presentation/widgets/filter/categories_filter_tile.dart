import 'package:flutter/material.dart';

class CategoriesFilterTile extends StatelessWidget {
  final String categoriesSelected;
  final VoidCallback onTap;
  const CategoriesFilterTile({
    super.key,
    required this.categoriesSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(
        'Categories',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        categoriesSelected,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}
