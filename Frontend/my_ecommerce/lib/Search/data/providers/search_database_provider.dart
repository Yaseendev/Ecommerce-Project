import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/services/database_service.dart';

class SearchDatabaseProvider extends DatabaseService {
  Box<String>? _searchBox;
  SearchDatabaseProvider(super.secureStorage) : super();

  Future<Box<String>> getHistoryBox() async {
    if (_searchBox == null) _searchBox = await Boxes.getSearchBox();
    return _searchBox!;
  }

  Future<List<String>> getHistory() async {
    if (_searchBox == null) _searchBox = await Boxes.getSearchBox();
    return _searchBox!.values.toList();
  }

  Future<int?> saveSearch(String term) async {
    if (_searchBox == null) _searchBox = await Boxes.getSearchBox();
    if (!_searchBox!.values.contains(term)) return _searchBox!.add(term);
    return null;
  }
}
