import 'package:flutter/material.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'search_result_tile.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({
    super.key,
    required this.result,
  });

  final List<Product> result;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: ListTile.divideTiles(
        context: context,
        tiles: [
          ...result.map((product) => GestureDetector(
                child: SearchResultTile(
                  product: product,
                ),
              )),
          SizedBox(height: 80),
        ],
      ).toList(),
    );
  }
}
