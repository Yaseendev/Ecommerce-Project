import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_ecommerce/Home/blocs/popular_bloc/popular_bloc.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/home_products_screen.dart';
import 'home_item_card.dart';
import 'loading/home_item_loading_card.dart';

class MostPopularSection extends StatelessWidget {
  const MostPopularSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBloc, PopularState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: state is PopularLoaded
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Most Popular',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => HomeProductsScreen(
                                      title: 'Most Popular',
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
                        height: 20,
                        width: 125,
                        margin: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
            StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              children: state is PopularLoaded
                  ? state.products
                      .map((prod) => StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1.23,
                            child: HomeItemCard(
                              product: prod,
                              width: double.maxFinite,
                              fromHome: true,
                            ),
                          ))
                      .toList()
                  : List.filled(6, HomeItemLoadingCard()),
            ),
          ],
        );
      },
    );
  }
}
