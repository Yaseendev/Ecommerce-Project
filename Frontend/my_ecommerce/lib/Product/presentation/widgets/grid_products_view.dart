import 'package:flutter/material.dart';
import 'package:my_ecommerce/Home/presentation/widgets/home_item_card.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';

class GridProductsView extends StatelessWidget {
  final List<Product> products;
  const GridProductsView({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //  padding: const EdgeInsets.all(12),
      itemCount: products.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / 500),
      ),
      itemBuilder: (context, index) {
        return HomeItemCard(
          product: products[index],
          width: double.maxFinite,
        );
      },
    );
  }
}
