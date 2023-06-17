import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Order/blocs/checkout_bloc/checkout_bloc.dart';
import 'package:my_ecommerce/Product/presentation/widgets/loading/product_loading_widget.dart';
import 'package:my_ecommerce/Shared/widgets/dialogs.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'dart:math' as math;
import '../widgets/cart_item_card.dart';
import '../widgets/cart_prices_view.dart';
import '../widgets/coupon_card.dart';
import '../widgets/coupon_field.dart';
import '../widgets/empty_cart_view.dart';
import '../widgets/to_checkout_button.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final bool fromHome;
  const CartScreen({
    super.key,
    required this.fromHome,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  final CouponBloc couponBloc = CouponBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        print('cart state $state');
        if (state is CartLoaded) {
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Cart',
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
              ),
            ),
            centerTitle: true,
            elevation: 1,
            leading: widget.fromHome
                ? null
                : BackButton(
                    color: AppColors.PRIMARY_COLOR,
                  ),
            actions: [
              if (widget.fromHome)
                state is CartLoaded && state.cart.cartContent.isNotEmpty
                    ? TextButton(
                        onPressed: !isLoading
                            ? () {
                                if (context.read<AccountBloc>().state
                                    is AccountLoggedIn) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          BlocProvider<CheckoutBloc>(
                                            create: (context) => CheckoutBloc(),
                                            child: CheckoutScreen(
                                              cart: state.cart,
                                            ),
                                          )));
                                } else {
                                  showLoginDialog(
                                      context, 'continue to checkout');
                                }
                              }
                            : null,
                        child: const Text('Checkout'),
                      )
                    : Container(),
            ],
          ),
          //buildWhen: (previous, current) => current is! CartError,
          body: state is CartLoading
              ? ProductLoadingWidget(
                  isGridView: false,
                )
              : Column(
                  children: [
                    Expanded(
                      child: state is CartLoaded
                          ? state.cart.cartContent.isEmpty
                              ? const EmptyCartView()
                              : Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(8.0),
                                        children: state.cart.cartContent
                                            .map((e) => CartItemCard(
                                                  product: e,
                                                  onUpdating: () {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                  },
                                                ))
                                            .toList(),
                                        // [
                                        //   ...ListTile.divideTiles(
                                        //     context: context,
                                        //     tiles: List.generate(
                                        //       state.cart.cartContent.length,
                                        //       (index) => CartItemCard(
                                        //         product: state
                                        //             .cart.cartContent[index],
                                        //         onDelete: () {
                                        //           setState(() {
                                        //             state.cart.cartContent
                                        //                 .removeAt(index);
                                        //           });
                                        //         },
                                        //         onUpdating: () {
                                        //           setState(() {
                                        //             isLoading = true;
                                        //           });
                                        //         },
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ],
                                      ),
                                    ),
                                    if (context.watch<AccountBloc>().state
                                        is AccountLoggedIn)
                                      BlocListener<CouponBloc, CouponState>(
                                        bloc: couponBloc,
                                        listener: (context, cState) {
                                          if (cState is CouponValid) {
                                              context.read<CartBloc>().add(
                                                      SetCart(cState.cart));
                                            
                                          } else if (cState is CouponFailed) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(cState.msg)));
                                          } else if (cState
                                              is CouponNoInternet) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: Icon(
                                                  Icons.error,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  'No Internet Connection',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          } else if (cState is CouponFailed) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: Icon(
                                                  Icons.error,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  cState.msg,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          }
                                        },
                                        child: BlocProvider<CouponBloc>(
                                          create: (context) => couponBloc,
                                       child: state.cart.coupon == null
                                            ? CouponField(
                                                onApply: (value) {
                                                  couponBloc
                                                      .add(CheckCoupon(
                                                          value.trim()));
                                                },
                                              )
                                            : CouponCard(state.cart.coupon!)),
                                      ),
                                    SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const CartPricesView(),
                                            if (!widget.fromHome)
                                              ToCheckoutButton(
                                                cart: state.cart,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                          : Container(),
                    ),
                    widget.fromHome
                        ? SizedBox(
                            height: kBottomNavigationBarHeight +
                                math.max(MediaQuery.of(context).padding.bottom,
                                    0.0) -
                                18,
                            // MediaQuery.of(context).size.width * .26
                          )
                        : Container(),
                  ],
                ),
        );
      },
    );
  }
}
