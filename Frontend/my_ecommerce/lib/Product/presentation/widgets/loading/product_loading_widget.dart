import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'product_loading_card.dart';

class ProductLoadingWidget extends StatelessWidget {
  final bool isGridView;
  const ProductLoadingWidget({
    super.key,
    this.isGridView = true,
  });

  @override
  Widget build(BuildContext context) {
    return isGridView
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: GridView.builder(
              //padding: const EdgeInsets.all(12),
              itemCount: 6,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.width / 480),
              ),
              itemBuilder: (context, index) => const ProductLoadingCard(),
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              children: List.filled(
                6,
                Container(
                  margin: const EdgeInsets.all(6),
                  width: double.maxFinite,
                  height: 135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
  }
}
