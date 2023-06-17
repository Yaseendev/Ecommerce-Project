import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Product/presentation/widgets/grid_products_view.dart';
import 'package:my_ecommerce/Product/presentation/widgets/list_products_view.dart';
import 'package:my_ecommerce/Product/presentation/widgets/loading/product_loading_widget.dart';
import 'package:my_ecommerce/Shared/widgets/no_internet_view.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/enums.dart';
import 'package:my_ecommerce/Wishlist/bloc/wishlist_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({
    super.key,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  ViewType viewType = ViewType.grid;
  final List<bool> selectedViews = [true, false];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      buildWhen: (previous, current) =>
          previous is! WishlistLoaded && current is! WishlistLoading,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Favorite Items',
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
              ),
            ),
            leading: BackButton(
              color: AppColors.PRIMARY_COLOR,
            ),
            centerTitle: true,
            elevation: 1,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(14),
                  children: [
                    const Icon(Icons.grid_view_rounded),
                    const Icon(Icons.view_list_rounded),
                  ],
                  isSelected: selectedViews,
                  onPressed: (index) {
                    if (!selectedViews[index]) {
                      selectedViews.fillRange(0, selectedViews.length, false);
                      setState(() {
                        selectedViews[index] = !selectedViews[index];
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: state is WishlistLoading
                    ? ProductLoadingWidget(
                        isGridView: selectedViews.first,
                      )
                    : state is WishlistLoaded
                        ? selectedViews.first
                            ? GridProductsView(
                                products: state.products,
                              )
                            : ListProductsView(
                                products: state.products,
                              )
                        : state is WishlistNoInternet
                            ? const NoInternetView()
                            : Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
