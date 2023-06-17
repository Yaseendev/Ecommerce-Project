import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            Images.EMPTY_CART,
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * .34,
            width: MediaQuery.of(context).size.width * .6,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Your Cart Is Empty',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
