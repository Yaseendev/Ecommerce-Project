import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Primary/blocs/categories_bloc/categories_bloc.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/categories_screen.dart';
import 'category_home_card.dart';
import 'loading/category_home_loading_card.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                state is CategoriesLoaded
                    ? Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                state is CategoriesLoaded
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => CategoriesScreen(
                                    categories: state.categories,
                                  )));
                        },
                        child: const Text('See All'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: AppColors.PRIMARY_COLOR,
                        ),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: state is CategoriesLoaded
                  ? null
                  : NeverScrollableScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: state is CategoriesLoaded
                    ? state.categories.map((e) => CategoryHomeCard(e)).toList()
                    : List.filled(5, CategoryHomeLoadingCard()),
              ),
            ),
          ],
        );
      },
    );
  }
}
