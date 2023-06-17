import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Product/presentation/screens/product_screen.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class SearchResultTile extends StatelessWidget {
  final Product product;
  const SearchResultTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductScreen(
            product: product,
          ))),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      image: product.images.first,
                      width: 100,
                      height: 90,
                      placeholder: Images.PLACEHOLDER,
                      imageErrorBuilder: (context, url, error) => Image.asset(
                        Images.PLACEHOLDER,
                        width: 100,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 235,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RatingBar.builder(
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {},
                            itemSize: 20, 
                            allowHalfRating: true,
                            ignoreGestures: true,
                            initialRating: product.rating,
                          ),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            intl.NumberFormat.simpleCurrency(name: 'EGP')
                                .format(product.price)
                                .split('.00')
                                .first,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text('Eligible for FREE Shipping'),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: const Text(
                            'In Stock',
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
