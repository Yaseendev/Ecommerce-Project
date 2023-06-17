import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeItemLoadingCard extends StatelessWidget {
  const HomeItemLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 0,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
