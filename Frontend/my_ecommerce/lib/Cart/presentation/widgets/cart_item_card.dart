import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_item_bloc/cart_item_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/cart_item.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:intl/intl.dart' as intl;

class CartItemCard extends StatefulWidget {
  final CartItem product;
  final VoidCallback onUpdating;
  const CartItemCard({
    super.key,
    required this.product,
    required this.onUpdating,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late int quantity;
  late final CartItemBloc cartItemBloc;

  @override
  void initState() {
    quantity = widget.product.quantity;
    super.initState();
    cartItemBloc = CartItemBloc(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartItemBloc, CartItemState>(
      bloc: cartItemBloc,
      listener: (context, state) {
        if (state is CartItemLoading) {
          print('Cart item loading');
          widget.onUpdating();
        } else if (state is CartItemUpdated) {
          context.read<CartBloc>().add(CartUpdate(state.cart));
        } else if (state is CartItemDeleted) {
          context.read<CartBloc>().add(CartUpdate(state.cart));
        }
      },
      builder: (context, state) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          direction: context.watch<CartBloc>().state is CartLoading ||
                  state is CartItemLoading
              ? DismissDirection.none
              : DismissDirection.endToStart,
          onDismissed: (direction) {
            context.read<CartBloc>().add(RemoveItem(widget.product.product.id));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    image: widget.product.product.images.first,
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
                SizedBox(width: 10),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(widget.product.product.name),
                    subtitle: Text(
                      intl.NumberFormat.simpleCurrency(name: 'EGP')
                          .format(widget.product.product.salePrice)
                          .split('.00')
                          .first,
                    ),
                    trailing: SizedBox(
                      width: 40 * 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black12,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 32,
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: state is CartItemLoading
                                        ? null
                                        : () {
                                            cartItemBloc.add(DecreaseQuantity(
                                                item: widget.product.copyWith(
                                                    qty: widget
                                                            .product.quantity -
                                                        1)));

                                            // if (quantity <= 1) {
                                            //   context.read<CartBloc>().add(
                                            //       RemoveItem(
                                            //           widget.product.id ?? ''));
                                            // } else {
                                            // setState(() {
                                            //   quantity--;
                                            // });
                                            // context.read<CartBloc>().add(
                                            //     CartUpdate(widget.product
                                            //         .copyWith(qty: quantity)));
                                            //}
                                          },
                                    icon: Icon(Icons.remove),
                                    alignment: Alignment.center,
                                    iconSize: 18,
                                    padding: EdgeInsets.zero,
                                    style: IconButton.styleFrom(
                                      alignment: Alignment.center,
                                      iconSize: 18,
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 35,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 1.5,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  alignment: Alignment.center,
                                  child: state is CartItemLoading
                                      ? Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        )
                                      : Text(state is CartItemUpdated
                                          ? state.item.quantity.toString()
                                          : quantity.toString()),
                                ),
                                Container(
                                  width: 35,
                                  height: 32,
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: state is CartItemLoading
                                        ? null
                                        : () {
                                            cartItemBloc.add(IncreaseQuantity(
                                                item: widget.product.copyWith(
                                                    qty: widget
                                                            .product.quantity +
                                                        1)));
                                            // setState(() {
                                            //   quantity++;
                                            // });
                                            // context.read<CartBloc>().add(CartUpdate(
                                            //     widget.product
                                            //         .copyWith(qty: quantity)));
                                          },
                                    icon: Icon(Icons.add),
                                    alignment: Alignment.center,
                                    iconSize: 18,
                                    padding: EdgeInsets.zero,
                                    style: IconButton.styleFrom(
                                      alignment: Alignment.center,
                                      iconSize: 18,
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
