import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryHomeLoadingCard extends StatelessWidget {
  const CategoryHomeLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: 85,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
            ),
            SizedBox(height: 5),
            Container(
              height: 11,
              width: 40,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
