import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:intl/intl.dart' as intl;

class CartPricesView extends StatelessWidget {
  const CartPricesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Sub-total:',
                    style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  state is CartLoaded
                      ? Text(
                          intl.NumberFormat.simpleCurrency(name: 'EGP')
                              .format(state.cart.subtotal)
                              .split('.00')
                              .first,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      : SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 3,
                          ),
                        ),
                ],
              ),
              state is CartLoaded
                  ? state.cart.coupon == null
                      ? Container()
                      : Text(
                          'Disscount:  - ${intl.NumberFormat.simpleCurrency(name: 'EGP').format(state.cart.coupon!.value).split('.00').first}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                  : Container(),
              Row(
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  state is CartLoaded
                      ? Text(
                          intl.NumberFormat.simpleCurrency(name: 'EGP')
                              .format(state.cart.total)
                              .split('.00')
                              .first,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 3,
                          ),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
