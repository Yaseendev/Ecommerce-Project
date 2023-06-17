import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_item_bloc/cart_item_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:my_ecommerce/Cart/presentation/screens/cart_screen.dart';

class CartButtonsSection extends StatelessWidget {
  final Function(BuildContext ctx) onPress;
  final VoidCallback onAdd;
  const CartButtonsSection({
    super.key,
    required this.onPress,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartItemBloc, CartItemState>(
      listener: (context, state) {
        if (state is CartItemAdded) {
          context.read<CartBloc>().add(AddItem(state.cart));
          onAdd();
        }
      },
      child: SizedBox(
        height: 65,
        child: Material(
          elevation: 35,
          type: MaterialType.card,
          borderOnForeground: true,
          shadowColor: Colors.black,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) => current is CartLoaded,
                  builder: (context, state) {
                    if (state is CartLoaded)
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Badge.count(
                          count: state.cart.cartContent.length,
                          alignment: AlignmentDirectional.topEnd,
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          smallSize: 15,
                          largeSize: 22,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          child: SizedBox(
                            height: 48,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => CartScreen(
                                        fromHome: false,
                                      )));
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 30,
                                )),
                          ),
                        ),
                      );
                    return Container();
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: BlocBuilder<CartItemBloc, CartItemState>(
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: state is CartItemLoading
                              ? null
                              : () {
                                  onPress(context);
                                },
                          label: Text(state is CartItemLoading
                              ? 'Adding To Cart...'
                              : 'Add To Cart'),
                          icon: state is CartItemLoading
                              ? Center(
                                  child: CircularProgressIndicator.adaptive())
                              : Icon(Icons.add_shopping_cart_rounded),
                        );
                      },
                    ),
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
