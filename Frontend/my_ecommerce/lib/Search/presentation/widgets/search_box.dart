import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Search/data/repositories/search_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';
import 'suggestion_tile.dart';

class SearchBox extends StatefulWidget {
  final String? initialVal;
  final Function(String value) onPress;
  final Function(TextEditingController controller) onController;
  final bool fromHome;
  const SearchBox({
    super.key,
    required this.onPress,
    this.initialVal,
    required this.onController,
    this.fromHome = true,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String searchText = '';
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController(
      text: widget.initialVal,
    );
    super.initState();
    widget.onController(_searchController);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TypeAheadField(
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            textFieldConfiguration: TextFieldConfiguration(
              maxLines: 1,
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    width: 0,
                    color: Color(0xFFF6F6F6),
                    style: BorderStyle.none,
                  ),
                ),
                constraints: BoxConstraints.expand(
                  width: double.infinity,
                  height: 45,
                ),
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: 'Search',
                fillColor: Colors.white,
                filled: true,
              ),
              textAlignVertical: TextAlignVertical.bottom,
            ),
            hideOnLoading: true,
            minCharsForSuggestions: 1,
            suggestionsCallback: (pattern) async {
              if (widget.fromHome) {
                List<Product>? resProducts;
                await locator
                    .get<SearchRepository>()
                    .searchProducts(pattern)
                    .then((value) =>
                        value.fold((l) => null, (r) => resProducts = r));

                return resProducts!;
              }
              return [];

            },
            autoFlipDirection: true,
            keepSuggestionsOnLoading: false,
            hideOnEmpty: true,
            hideOnError: true,
            itemBuilder: (context, suggestion) => SuggestionTile(suggestion),
            onSuggestionSelected: (suggestion) {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (_) => ProductScreen(
              //       product: suggestion,
              //     )));
            },
          ),
        ),
        const SizedBox(width: 6),
        ElevatedButton(
          onPressed: () {
            widget.onPress(_searchController.text);
          },
          child: Icon(Icons.search_rounded),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
