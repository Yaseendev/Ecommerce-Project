import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddressLoadingCard extends StatelessWidget {
  const AddressLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
      ),
    );
  }
}
