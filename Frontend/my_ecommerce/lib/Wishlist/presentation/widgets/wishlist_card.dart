import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Product/presentation/screens/product_screen.dart';
import 'package:my_ecommerce/Product/product_bloc/product_bloc.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Wishlist/bloc/wishlist_bloc.dart';

class WishlistCard extends StatelessWidget {
  final Product product;
  const WishlistCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BlocProvider<ProductBloc>(
                create: (context) => ProductBloc(),
                child: ProductScreen(
                  product: product,
                ),
              ))),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              image: product.images.first,
              //height: MediaQuery.of(context).size.height * .5,
              // width: double.infinity,
              placeholder: Images.PLACEHOLDER,
              imageErrorBuilder: (context, url, error) => Image.asset(
                Images.PLACEHOLDER,
                // height:
                //     MediaQuery.of(context).size.height * .5,
                // width: double.infinity,
              ),
            ),
          ),
          title: Text(
            product.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(product.desc),
          trailing: IconButton(
            icon: Icon(Icons.favorite_rounded),
            color: Colors.red,
            onPressed: () {
              context.read<WishlistBloc>().add(RemoveFromlist(product.id));
            },
          ),
        ),
      ),
    );
  }
}
