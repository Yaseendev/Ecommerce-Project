import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Shared/widgets/dialogs.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Wishlist/bloc/wishlist_bloc.dart';
import '../screens/product_screen.dart';

class ProudctListTile extends StatelessWidget {
  final Product product;
  const ProudctListTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OpenContainer<bool>(
          openBuilder: (context, action) => ProductScreen(
            product: product,
          ),
          tappable: false,
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          closedElevation: 0,
          closedBuilder: (context, openContainer) => GestureDetector(
            onTap: openContainer,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: product.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.fill,
                        image: product.images.isNotEmpty
                            ? product.images.first
                            : '',
                        width: 125,
                        height: 115,
                        imageErrorBuilder: (context, url, error) => Image.asset(
                          Images.PLACEHOLDER,
                          width: 125,
                          height: 115,
                          fit: BoxFit.fill,
                        ),
                        placeholder: Images.PLACEHOLDER,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 6),
                      isThreeLine: true,
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.brand),
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
                                itemSize: 16,
                              ),
                              Text(
                                ' (${product.rating})',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          if (product.salePrice != null)
                            Text(
                              intl.NumberFormat.simpleCurrency(name: 'EGP')
                                  .format(product.price)
                                  .split('.00')
                                  .first,
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            intl.NumberFormat.simpleCurrency(name: 'EGP')
                                    .format(product.salePrice == null
                                        ? product.price
                                        : product.salePrice)
                                    .split('.00')
                                    .first +
                                '  ',
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
               final bool isWishlisted = state is WishlistLoaded &&
                                state.products
                                    .any((element) => element.id == product.id);

              return ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    CircleBorder(),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  if (context.read<AccountBloc>().state is AccountLoggedIn) {
                    context.read<WishlistBloc>().add(isWishlisted
                        ? RemoveFromlist(product.id)
                        : AddToWishlist(product));
                  } else {
                    showLoginDialog(context, 'add this item to your wishlist');
                  }
                },
                child: state is WishlistLoading &&
                                      state.productId == product.id
                                  ? SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Icon(
                                      isWishlisted
                                          ? Icons.favorite_rounded
                                          : state.products != null && state.products!.any((element) => element.id == product.id)
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_outline_rounded,
                                      color: isWishlisted
                                          ? Colors.red
                                          : state.products != null && state.products!.any((element) => element.id == product.id)
                                              ? Colors.red
                                              : Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color,
                                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}
