import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Product/presentation/widgets/loading/product_loading_widget.dart';
import 'package:my_ecommerce/Search/blocs/search_bloc/search_bloc.dart';
import 'package:my_ecommerce/Search/data/models/search_criteria.dart';
import 'package:my_ecommerce/Shared/widgets/error_view.dart';
import 'package:my_ecommerce/Shared/widgets/no_internet_view.dart';
import '../widgets/filter/filter_sheet.dart';
import '../widgets/search_box.dart';
import '../widgets/search_history_card.dart';
import '../widgets/search_result_view.dart';

class SearchScreen extends StatefulWidget {
  final String? searchTerm;
  const SearchScreen({
    super.key,
    this.searchTerm,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //final Set<Category> selectedCategories = {};

  String? searchterm;
  late TextEditingController textController;
  SearchCriteria? searchCriteria;

  @override
  void initState() {
    searchterm = widget.searchTerm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            Expanded(
              child: SearchBox(
                onController: (controller) {
                  textController = controller;
                },
                onPress: (value) {
                  if (textController.text.trim().isNotEmpty) {
                    context.read<SearchBloc>().add(FetchSearchData(
                        searchTxt: textController.text.trim(),
                        searchCriteria: searchCriteria));
                  }
                },
                initialVal: searchterm,
                fromHome: false,
              ),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.all(10)),
              child: Center(child: Icon(Icons.tune)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  // useRootNavigator: true,
                  useSafeArea: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(14),
                    ),
                  ),
                  builder: (ctx) {
                    return FilterSheet(
                      searchCriteria: searchCriteria,
                    );
                  },
                ).then((value) {
                  if (value is SearchCriteria) {
                    searchCriteria = value;
                    if (textController.text.trim().isNotEmpty) {
                      context.read<SearchBloc>().add(FetchSearchData(
                          searchTxt: textController.text.trim(),
                          searchCriteria: searchCriteria));
                    }
                  } else if (value is bool && !value) {
                    searchCriteria = null;
                    if (textController.text.trim().isNotEmpty) {
                      context.read<SearchBloc>().add(FetchSearchData(
                          searchTxt: textController.text.trim()));
                    }
                  }
                  print('Searched ${value.runtimeType}');
                });
              },
            ),
          ],
        ),
        elevation: 0,
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading)
            return ProductLoadingWidget(
              isGridView: false,
            );
          if (state is SearchLoaded)
            return SearchResultView(result: state.products);
          if (state is SearchHistoryLoaded)
            return ValueListenableBuilder(
              valueListenable: state.history,
              builder: (context, Box<String> box, _) {
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, listIndex) {
                    final item = box.values.elementAt(listIndex);
                    return SearchHistroyCard(
                      title: item,
                      onPress: () {
                        searchterm = box.values.elementAt(listIndex);

                        textController.text = searchterm!;

                        context
                            .read<SearchBloc>()
                            .add(FetchSearchData(searchTxt: searchterm!));
                      },
                    );
                  },
                );
              },
            );
          if (state is SearchNoInternet) return NoInternetView();
          if (state is SearchError)
            return ErrorView(
              errorTxt: state.msg,
            );
          return Container();
        },
      ),
    );
  }
}
