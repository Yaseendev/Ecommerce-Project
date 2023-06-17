import 'package:flutter/material.dart';

class ProductLoadingCard extends StatelessWidget {
  const ProductLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 160,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),),
    );
  }
}