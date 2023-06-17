import 'package:flutter/material.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'proudct_list_tile.dart';

class ListProductsView extends StatelessWidget {
  final List<Product> products;
  const ListProductsView({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => ProudctListTile(product: products[index]),
    );
  }
}
