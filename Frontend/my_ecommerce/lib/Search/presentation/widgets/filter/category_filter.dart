import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Primary/blocs/categories_bloc/categories_bloc.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Search/data/models/filter_check_state.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'category_filter_tile.dart';

class CategoryFilter extends StatefulWidget {
  final Function onBack;
  final Set<Category> selectedCategories;
  const CategoryFilter({
    super.key,
    required this.onBack,
    required this.selectedCategories,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  //late final FilterCheckState all;

  @override
  void initState() {
    // values = widget.allCategories
    //     .map((cat) => FilterCheckState(
    //           icon: Image.network(cat.imgUrl),
    //           title: cat.name,
    //           value: widget.selectedCategories.isEmpty ||
    //               widget.selectedCategories.contains(cat),
    //         ))
    //     .toList();
    // all = FilterCheckState(
    //   icon: Icon(Icons.category_rounded),
    //   title: 'all',
    //   value: ,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  shape: MaterialStateProperty.all(
                    CircleBorder(),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFF5F5F5)),
                  alignment: Alignment.center,
                  // /padding: MaterialStateProperty.all(EdgeInsets.only(left: 10)),
                ),
                onPressed: () {
                  widget.onBack();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 26,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                right: 16,
                left: 16,
                bottom: 10,
              ),
              child: Text(
                'Categories',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoaded) {
              return ListView(
                shrinkWrap: true,
                children: [
                  CheckboxListTile(
                    title: Text('All'),
                    secondary: Icon(Icons.category_rounded),
                    value: widget.selectedCategories.isEmpty ||
                        widget.selectedCategories.length ==
                            state.categories.length,
                    //values.every((element) => element.value),
                    activeColor: AppColors.PRIMARY_COLOR,
                    onChanged: (value) => toggleGroup(value, state.categories),
                  ),
                  const Divider(),
                  ...state.categories.map((cat) => CategoryFilterTile(
                        value: widget.selectedCategories.isEmpty ||
                            widget.selectedCategories.contains(cat),
                        onCheck: (value) {
                          setState(() {
                            value
                                ? widget.selectedCategories.add(cat)
                                : widget.selectedCategories.isEmpty
                                    ? widget.selectedCategories.addAll(state
                                        .categories
                                        .where((catVal) => catVal.id != cat.id))
                                    : widget.selectedCategories.remove(cat);
                          });
                        },
                        category: cat,
                      )),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ],
    );
  }

  Widget buildCheckBox(FilterCheckState checkState) => CheckboxListTile(
        title: Text(checkState.title),
        secondary: checkState.icon,
        value: checkState.value,
        activeColor: AppColors.PRIMARY_COLOR,
        onChanged: (value) {
          setState(() {
            checkState.value = value ?? false;
          });
        },
      );

  void toggleGroup(bool? state, List<Category> cats) {
    if (state != null) {
      setState(() {
        !state
            ? widget.selectedCategories.addAll(cats)
            : widget.selectedCategories.clear();
      });
    }
  }
}
