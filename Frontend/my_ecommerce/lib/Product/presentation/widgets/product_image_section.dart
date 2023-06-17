import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Shared/widgets/dialogs.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Wishlist/bloc/wishlist_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ProductImageSection extends StatelessWidget {
  final Product product;
  const ProductImageSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: product.id,
            child: BannerCarousel(
              margin: EdgeInsets.zero,
              banners: product.images
                  .asMap()
                  .entries
                  .map((entry) => BannerModel(
                        id: '${entry.key}',
                        imagePath: entry.value,
                        boxFit: BoxFit.fill,
                      ))
                  .toList(),
              animation: true,
              borderRadius: 4,
              showIndicator: product.images.length > 1,
              height: MediaQuery.of(context).size.height * .35,
              activeColor: AppColors.PRIMARY_COLOR,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                BlocBuilder<WishlistBloc, WishlistState>(
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
                          showLoginDialog(
                              context, 'add this item to your wishlist');
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
                                  : state.products != null &&
                                          state.products!.any((element) =>
                                              element.id == product.id)
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_outline_rounded,
                              color: isWishlisted
                                  ? Colors.red
                                  : state.products != null &&
                                          state.products!.any((element) =>
                                              element.id == product.id)
                                      ? Colors.red
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                            ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      CircleBorder(),
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.PRIMARY_COLOR),
                  ),
                  onPressed: product.link.isNotEmpty
                      ? () {
                          Share.share(product.link);
                        }
                      : null,
                  child: const Icon(
                    Icons.share_rounded,
                    color: AppColors.SECONDARY_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
