import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductHomeHLoadingCard extends StatelessWidget {
  const ProductHomeHLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.only(right: 18),
        child: SizedBox(
          width: 135,
          height: 145,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}
