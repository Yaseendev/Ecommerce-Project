import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Product/presentation/screens/product_screen.dart';
import 'package:my_ecommerce/Shared/widgets/dialogs.dart';
import 'package:my_ecommerce/Shared/widgets/open_container_wrapper.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Wishlist/bloc/wishlist_bloc.dart';

class HomeItemCard extends StatelessWidget {
  final Product product;
  final double width;
  final bool fromHome;
  const HomeItemCard({
    super.key,
    required this.product,
    required this.width,
    this.fromHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OpenContainerWrapper(
        transitionType: ContainerTransitionType.fade,
        openWidget: ProductScreen(
          product: product,
        ),
        closedBuilder: (context, action) => GestureDetector(
          onTap: () => action(),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.fill,
                          image: product.images.isNotEmpty
                              ? product.images.first
                              : '',
                          width: width,
                          height: double.infinity,
                          imageErrorBuilder: (context, url, error) =>
                              Image.asset(
                            Images.PLACEHOLDER,
                            height: double.infinity,
                            width: width,
                            fit: BoxFit.fill,
                          ),
                          placeholder: Images.PLACEHOLDER,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: BlocBuilder<WishlistBloc, WishlistState>(
                          //buildWhen: (previous, current) => current is WishlistLoaded && current.,
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
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(8)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {
                                if (context.read<AccountBloc>().state
                                    is AccountLoggedIn) {
                                  context.read<WishlistBloc>().add(isWishlisted
                                      ? RemoveFromlist(product.id)
                                      : AddToWishlist(product));
                                } else {
                                  showLoginDialog(context,
                                      'add this item to your wishlist');
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
                      if (product.salePercentage != null)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${product.salePercentage}% Off',
                                style: TextStyle(
                                  color: AppColors.SECONDARY_COLOR,
                                ),
                              ),
                            ),
                            color: AppColors.PRIMARY_COLOR.withOpacity(.8),
                            elevation: 0,
                            shape: StadiumBorder(),
                          ),

                          // Chip(
                          //   label: Text('${product.salePercentage}% Off'),
                          //   backgroundColor: Colors.transparent,

                          //   labelStyle:
                          //       TextStyle(color: AppColors.SECONDARY_COLOR),
                          // ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (fromHome)
                        Text(
                          product.category.name,
                          style: TextStyle(
                            fontSize: 13.5,
                          ),
                        ),
                      if (fromHome) const SizedBox(height: 5),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.5,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                            itemSize: 14,
                          ),
                          Text(
                            ' (${product.rating})',
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          text: intl.NumberFormat.simpleCurrency(name: 'EGP')
                                  .format(product.salePrice == null
                                      ? product.price
                                      : product.salePrice)
                                  .split('.00')
                                  .first +
                              ' ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            if (product.salePercentage != null)
                              TextSpan(
                                text: intl.NumberFormat.simpleCurrency(
                                        name: 'EGP')
                                    .format(product.price)
                                    .split('.00')
                                    .first,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
