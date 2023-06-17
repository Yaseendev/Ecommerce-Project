import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Account/data/models/name.dart';
import 'package:my_ecommerce/Account/data/models/user.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Cart/data/models/cart_item.dart';
import 'package:my_ecommerce/Primary/data/models/category.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences? prefs;

  DatabaseService(
      [this.secureStorage = const FlutterSecureStorage(), this.prefs]) {
    if (!Hive.isAdapterRegistered(0))
      Hive
        ..registerAdapter(UserAdapter())
        ..registerAdapter(NameAdapter())
        ..registerAdapter(CategoryAdapter())
        ..registerAdapter(ProductAdapter())
        ..registerAdapter(CartItemAdapter())
        ..registerAdapter(CartAdapter());
  }
}
