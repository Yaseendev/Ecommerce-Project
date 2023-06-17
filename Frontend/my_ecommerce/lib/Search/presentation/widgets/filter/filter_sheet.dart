import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Search/blocs/filter_bloc/filter_bloc.dart';
import 'package:my_ecommerce/Search/data/models/search_criteria.dart';
import 'category_filter.dart';
import 'filter_form.dart';

class FilterSheet extends StatefulWidget {
  final SearchCriteria? searchCriteria;
  const FilterSheet({
    super.key,
    required this.searchCriteria,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  final PageController pageController = PageController();
  SearchCriteria? searchCriteria;

  @override
  void initState() {
    searchCriteria = widget.searchCriteria;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .65,
      ),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          if (state is FilterReady) {
            return WillPopScope(
              onWillPop: onWillPop,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  FilterForm(
                    searchCriteria: searchCriteria,
                    brands: state.allBrands,
                    onCategory: () => goToPage(1),
                  ),
                  CategoryFilter(
                    selectedCategories: searchCriteria != null
                        ? searchCriteria!.selectedCategories
                        : {},
                    onBack: () => goToPage(0),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (pageController.page?.toInt() == 0) {
      return Future.value(true);
    } else {
      goToPage(0);
      return Future.value(false);
    }
  }

  Future<void> goToPage(int page, [int? optionPage]) async {
    pageController.animateToPage(page,
        duration: Duration(milliseconds: 120), curve: Curves.easeIn);
  }
}
