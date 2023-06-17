import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:intl/intl.dart' as intl;

class ProductHeader extends StatelessWidget {
  final Product product;
  const ProductHeader({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            product.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(product.brand),
              const SizedBox(height: 5),
              Row(
                children: [
                  RatingBar.builder(
                    minRating: 0.5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {},
                    allowHalfRating: true,
                    ignoreGestures: true,
                    initialRating: product.rating,
                    itemSize: 23,
                  ),
                  Text('(${product.rating})'),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              product.salePrice == null
                  ? Text(
                    intl.NumberFormat.simpleCurrency(name: 'EGP')
                                  .format(product.price)
                                  .split('.00')
                                  .first,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                          intl.NumberFormat.simpleCurrency(name: 'EGP')
                                  .format(product.price)
                                  .split('.00')
                                  .first,
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          '${product.salePrice?.toStringAsFixed(2)} EGP',
                          style: TextStyle(
                            //color: AppColors.PRIMARY_COLOR,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const Divider(),
        //const SizedBox(height: 5),
        Text(
          'Description:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            product.desc,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Divider(),
        const SizedBox(height: 5),
      ],
    );
  }
}
