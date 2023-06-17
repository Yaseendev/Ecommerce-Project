import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce/Home/presentation/widgets/product_home_card_h.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Product/presentation/screens/product_screen.dart';
import 'package:my_ecommerce/Shared/widgets/open_container_wrapper.dart';

class RelatedProductsView extends StatelessWidget {
  final List<Product> products;
  const RelatedProductsView({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //  padding: const EdgeInsets.all(12),
      itemCount: products.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: (MediaQuery.of(context).size.width / 500),
      ),
      itemBuilder: (context, index) {
        return OpenContainerWrapper(
          transitionType: ContainerTransitionType.fade,
          closedBuilder: (context, action) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ProductHomeHCard(
              product: products[index],
              openContainer: action,
            ),
          ),
          openWidget: ProductScreen(
            product: products[index],
          ),
        );
      },
    );
  }
}
