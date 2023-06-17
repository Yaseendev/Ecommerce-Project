import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_item_bloc/cart_item_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/cart_item.dart';
import 'package:my_ecommerce/Primary/blocs/category_bloc/category_bloc.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Product/product_bloc/product_bloc.dart';
import 'package:my_ecommerce/Shared/widgets/dialogs.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Wishlist/bloc/wishlist_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/loaded/cart_buttons_section.dart';
import '../widgets/loaded/product_header.dart';
import '../widgets/loaded/shipping_info_section.dart';
import '../widgets/product_image_section.dart';
import '../widgets/related_products_section.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final ScrollController _scrollController;
  int qty = 1;
  String selectedSize = 'M';
  //String selectedColor = ColorOption.black.name;
  bool get _isSliverAppBarCollapsed {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * .35) - kToolbarHeight;
  }

  final ProductBloc productBloc = ProductBloc();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    productBloc.add(FetchRelatedProducts(product: widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: _isSliverAppBarCollapsed
                  ? Text(
                      widget.product.name,
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    )
                  : null,
              leading: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    shape: MaterialStateProperty.all(
                      CircleBorder(),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFF5F5F5)),
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 26,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
              ),
              expandedHeight: MediaQuery.of(context).size.height * .35,
              flexibleSpace: FlexibleSpaceBar(
                background: ProductImageSection(
                  product: widget.product,
                ),
              ),
              actions: [
                if (_isSliverAppBarCollapsed)
                  BlocBuilder<WishlistBloc, WishlistState>(
                    builder: (context, state) {
                      final bool isWishlisted = state is WishlistLoaded &&
                          state.products.any(
                              (element) => element.id == widget.product.id);

                      return IconButton(
                        onPressed: () {
                          if (context.read<AccountBloc>().state
                              is AccountLoggedIn) {
                            context.read<WishlistBloc>().add(isWishlisted
                                ? RemoveFromlist(widget.product.id)
                                : AddToWishlist(widget.product));
                          } else {
                            showLoginDialog(
                                context, 'add this item to your wishlist');
                          }
                        },
                        icon: state is WishlistLoading &&
                                state.productId == widget.product.id
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
                                                element.id == widget.product.id)
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_outline_rounded,
                                color: isWishlisted
                                    ? Colors.red
                                    : state.products != null &&
                                            state.products!.any((element) =>
                                                element.id == widget.product.id)
                                        ? Colors.red
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                              ),
                      );
                    },
                  ),
                if (_isSliverAppBarCollapsed)
                  IconButton(
                    onPressed: widget.product.link.isNotEmpty
                        ? () {
                            Share.share(widget.product.link);
                          }
                        : null,
                    icon: const Icon(
                      Icons.share_rounded,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
              ],
            ),
          ],
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent,
            ),
            child: ListView(
              //shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              children: [
                ProductHeader(
                  product: widget.product,
                ),
                ShippingInfoSection(),
                const Divider(),
                BlocProvider<ProductBloc>(
                  create: (context) => productBloc,
                  child: RelatedProductsSection(
                    pId: widget.product.id,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MultiBlocProvider(
          providers: [
            BlocProvider<CartItemBloc>(
              create: (context) => CartItemBloc(context),
            ),
           
          ],
          child: CartButtonsSection(
            onPress: (ctx) {
              ctx.read<CartItemBloc>().add(AddItemToCart(
                      item: CartItem(
                    product: widget.product,
                    quantity: qty,
                  )));
            },
            onAdd: () {
              Fluttertoast.showToast(
                msg: "${widget.product.name} Added To Your Cart",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.NONE,
                timeInSecForIosWeb: 1,
                fontSize: 16.0,
              );
            },
          ),
        ),
      ),
    );
  }
}
