import 'package:flutter/material.dart';
import 'package:my_ecommerce/Search/data/models/search_criteria.dart';
import 'package:my_ecommerce/Utils/enums.dart';
import 'brand_filter_section.dart';
import 'categories_filter_tile.dart';
import 'filter_header.dart';
import 'price_range_view.dart';
import 'rating_range_view.dart';
import 'sort_view.dart';

class FilterForm extends StatefulWidget {
  final VoidCallback onCategory;
  final SearchCriteria? searchCriteria;
  final List<String> brands;
  const FilterForm({
    super.key,
    required this.onCategory,
    required this.searchCriteria,
    required this.brands,
  });

  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RangeValues? ratingRange;
  late SortOptions selectedSort;
  double? startPrice, endPrice;
  final Set<String> selectedBrands = {};

  @override
  void initState() {
    selectedSort = widget.searchCriteria?.selectedSort ?? SortOptions.most_relv;
    ratingRange = widget.searchCriteria?.ratingRange;
    startPrice = widget.searchCriteria?.startPrice;
    endPrice = widget.searchCriteria?.endPrice;
    selectedBrands.addAll(widget.searchCriteria == null
        ? {}
        : widget.searchCriteria!.selectedBrands);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FilterHeader(
            onDone: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(
                    context,
                    SearchCriteria(
                      selectedCategories: widget.searchCriteria != null
                          ? widget.searchCriteria!.selectedCategories
                          : {},
                      startPrice: startPrice,
                      endPrice: endPrice,
                      ratingRange: ratingRange,
                      selectedSort: selectedSort,
                      selectedBrands: selectedBrands,
                    ));
              } else
                print('Not Validated');
            },
          ),
          const Divider(),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: 14,
                right: 14,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              children: [
                SortView(
                  groupValue: selectedSort,
                  onSelectSort: (value) => setState(() => selectedSort = value),
                ),
                const Divider(),
                CategoriesFilterTile(
                  categoriesSelected: widget.searchCriteria == null
                      ? 'All'
                      : widget.searchCriteria!.selectedCategories.isEmpty
                          ? 'All'
                          : widget.searchCriteria!.selectedCategories
                              .map((e) => e.name)
                              .join(', '),
                  onTap: widget.onCategory,
                ),
                const Divider(),
                BrandsFilterSection(
                  allBrands: widget.brands,
                  selectedBrands: selectedBrands,
                  onAdd: (brand) {
                    setState(() {
                      selectedBrands.add(brand);
                    });
                  },
                  onRemove: (brand) {
                    setState(() {
                      selectedBrands.remove(brand);
                    });
                  },
                ),
                const Divider(),
                PriceRangeView(
                  startPrice: startPrice,
                  endPrice: endPrice,
                  onStartPriceChnage: (start) => startPrice = start,
                  onEndPriceChnage: (end) => endPrice = end,
                ),
                const Divider(),
                RatingRangeView(
                  onChange: (value) => setState(() {
                    ratingRange = value;
                  }),
                  ratingRange: ratingRange,
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
