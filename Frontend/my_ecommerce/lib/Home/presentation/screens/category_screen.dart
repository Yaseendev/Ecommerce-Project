import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Primary/blocs/category_bloc/category_bloc.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Product/presentation/widgets/grid_products_view.dart';
import 'package:my_ecommerce/Product/presentation/widgets/list_products_view.dart';
import 'package:my_ecommerce/Product/presentation/widgets/loading/product_loading_widget.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/enums.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isSearch = false;
  ViewType viewType = ViewType.grid;
  final List<bool> selectedViews = [true, false];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: isSearch && state is CategoryLoaded
                ? SizedBox(
                    height: 45,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            color: Color(0xFFF6F6F6),
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color(0xFFF6F6F6),
                        filled: true,
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.zero,
                      ),
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        context
                            .read<CategoryBloc>()
                            .add(FillterProducts(searchTerm: value.trim()));
                      },
                    ),
                  )
                : Text(
                    widget.category.name,
                    style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
            leading: BackButton(
              onPressed:
                  isSearch ? () => setState(() => isSearch = false) : null,
              color: AppColors.PRIMARY_COLOR,
            ),
            actions: [
              isSearch || state is! CategoryLoaded
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isSearch = true;
                        });
                      },
                      icon: Icon(Icons.search_rounded),
                      color: AppColors.PRIMARY_COLOR,
                    ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(14),
                      children: [
                        const Icon(Icons.grid_view_rounded),
                        const Icon(Icons.view_list_rounded),
                      ],
                      isSelected: selectedViews,
                      onPressed: (index) {
                        if (!selectedViews[index]) {
                          selectedViews.fillRange(
                              0, selectedViews.length, false);
                          setState(() {
                            selectedViews[index] = !selectedViews[index];
                          });
                        }
                      },
                    ),
                    state is CategoryLoaded
                        ? TextButton.icon(
                            onPressed: () {
                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   // useRootNavigator: true,
                              //   useSafeArea: true,
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.vertical(
                              //       top: const Radius.circular(14),
                              //     ),
                              //   ),
                              //   builder: (ctx) {
                              //     return FilterSheet(
                              //       allBrands: <String>[
                              //         'Brand 1',
                              //         'Brand 2',
                              //         'Brand 3',
                              //         'Brand 4',
                              //         'Brand 5',
                              //       ],
                              //     );
                              //   },
                              // );
                            },
                            icon: Icon(Icons.filter_list_rounded),
                            label: Text('Filter'),
                          )
                        : Container(),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    context
                        .read<CategoryBloc>()
                        .add(LoadCategory(categoryId: widget.category.id));
                    return Future.delayed(Duration(seconds: 1))
                        .then((value) => true);
                  },
                  child: state is CategoryLoaded
                      ? state.products.isEmpty
                          ? Center(
                              child: Text(
                                state.searchTerm != null
                                    ? state.searchTerm!.isNotEmpty
                                        ? 'No result found'
                                        : 'There is no ${widget.category.name} products yet'
                                    : 'There is no ${widget.category.name} products yet',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : selectedViews.first
                              ? GridProductsView(
                                  products: state.products,
                                )
                              : ListProductsView(
                                  products: state.products,
                                )
                      : ProductLoadingWidget(
                          isGridView: selectedViews.first,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
