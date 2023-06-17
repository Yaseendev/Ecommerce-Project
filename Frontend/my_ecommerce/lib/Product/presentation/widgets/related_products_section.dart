import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Product/product_bloc/product_bloc.dart';
import 'loaded/related_products_view.dart';
import 'loading/product_loading_widget.dart';

class RelatedProductsSection extends StatelessWidget {
  final String pId;
  const RelatedProductsSection({
    super.key,
    required this.pId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Products',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state is ProductLoaded
                ? RelatedProductsView(
                    products: state.products,
                  )
                : ProductLoadingWidget(
                    isGridView: true,
                  );
          },
        ),
      ],
    );
  }
}
