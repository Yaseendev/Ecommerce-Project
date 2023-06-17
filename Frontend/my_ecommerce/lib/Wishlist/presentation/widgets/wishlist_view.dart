import 'package:flutter/material.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'wishlist_card.dart';

class WishlistView extends StatelessWidget {
  final List<Product> result;
  const WishlistView({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return result.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            children: ListTile.divideTiles(
                context: context,
                tiles: result.map((product) => GestureDetector(
                      child: WishlistCard(
                        product: product,
                      ),
                    ))).toList(),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.WISHLIST,
                  fit: BoxFit.fill,
                  height: 25,
                  width: MediaQuery.of(context).size.width * .6,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 50),
                Text(
                  'No Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}
