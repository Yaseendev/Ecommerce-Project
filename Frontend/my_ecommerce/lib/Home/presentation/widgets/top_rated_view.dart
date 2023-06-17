import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Home/blocs/top_products_bloc/top_products_bloc.dart';
import 'package:my_ecommerce/Product/presentation/screens/product_screen.dart';
import 'package:my_ecommerce/Shared/widgets/open_container_wrapper.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/home_products_screen.dart';
import 'loading/product_home_h_loading_card.dart';
import 'product_home_card_h.dart';

class TopRatedView extends StatelessWidget {
  const TopRatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopProductsBloc, TopProductsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            state is TopProductsLoaded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Rated',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => HomeProductsScreen(
                                    title: 'Top Rated',
                                    products: state.products,
                                  )));
                        },
                        child: const Text('See All'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: AppColors.PRIMARY_COLOR,
                        ),
                      ),
                    ],
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 18,
                      width: 95,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: state is TopProductsLoaded
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state is TopProductsLoaded
                    ? state.products
                        .map((e) => OpenContainerWrapper(
                          transitionType: ContainerTransitionType.fade,
                          closedBuilder: (context, action) =>
                              ProductHomeHCard(
                            product: e,
                            openContainer: () {
                              action();
                            },
                          ),
                          openWidget: ProductScreen(
                            product: e,
                          ),
                        ))
                        .toList()
                    : List.filled(5, ProductHomeHLoadingCard()),
              ),
            ),
          ],
        );
      },
    );
  }
}
