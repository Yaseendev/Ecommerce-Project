import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Order/blocs/checkout_bloc/checkout_bloc.dart';
import 'package:my_ecommerce/Shared/widgets/dialogs.dart';

import '../screens/checkout_screen.dart';

class ToCheckoutButton extends StatelessWidget {
  final Cart cart;
  const ToCheckoutButton({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: state is CartLoading
                ? null
                : () {
                    if (context.read<AccountBloc>().state is AccountLoggedIn) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider<CheckoutBloc>(
                                create: (context) => CheckoutBloc(),
                                child: CheckoutScreen(
                                  cart: cart,
                                ),
                              )));
                      //context.read<CartBloc>()
                    } else {
                      showLoginDialog(context, 'continue to checkout');
                    }
                  },
            child: state is CartLoading
                ? Center(
                    child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ))
                : const Text(
                    'Procceed to checkout',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
