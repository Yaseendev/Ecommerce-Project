import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ecommerce/Account/data/providers/account_db_provider.dart';
import 'package:my_ecommerce/Account/data/providers/account_network_provider.dart';
import 'package:my_ecommerce/Account/data/repositories/account_repo.dart';
import 'package:my_ecommerce/Address/data/provider/address_network_provider.dart';
import 'package:my_ecommerce/Address/data/repositories/address_repo.dart';
import 'package:my_ecommerce/Address/data/repositories/location_repository.dart';
import 'package:my_ecommerce/Cart/data/providers/cart_db_provider.dart';
import 'package:my_ecommerce/Cart/data/providers/cart_network_provider.dart';
import 'package:my_ecommerce/Cart/data/repositories/cart_repository.dart';
import 'package:my_ecommerce/Home/data/providers/home_network_provider.dart';
import 'package:my_ecommerce/Home/data/repositories/home_repository.dart';
import 'package:my_ecommerce/Order/data/proivders/order_network_provider.dart';
import 'package:my_ecommerce/Order/data/repositories/order_repository.dart';
import 'package:my_ecommerce/Primary/data/providers/category_network_provider.dart';
import 'package:my_ecommerce/Primary/data/repositories/category_repo.dart';
import 'package:my_ecommerce/Product/data/providers/product_network_provider.dart';
import 'package:my_ecommerce/Product/data/repositories/product_repo.dart';
import 'package:my_ecommerce/Search/data/providers/search_database_provider.dart';
import 'package:my_ecommerce/Search/data/providers/search_network_provider.dart';
import 'package:my_ecommerce/Search/data/repositories/search_repo.dart';
import 'package:my_ecommerce/Wishlist/data/providers/wishlist_network_provider.dart';
import 'package:my_ecommerce/Wishlist/data/repositories/wishlist_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';
import 'location_service.dart';

final locator = GetIt.instance;

Future locatorsSetup() async {
  final DatabaseService database = DatabaseService();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  locator.registerLazySingleton<Connectivity>(() => Connectivity());
  locator.registerLazySingleton<AccountNetworkProvider>(() => AccountNetworkProvider());
  locator.registerLazySingleton<AccountDatabaseProvider>(() => AccountDatabaseProvider(database.secureStorage,prefs));
  locator.registerLazySingleton<AccountRepository>(() => AccountRepository(
    networkProvider: locator.get<AccountNetworkProvider>(),
    databaseProvider: locator.get<AccountDatabaseProvider>(),
  ));
   locator.registerLazySingleton<WishlistNetworkProvider>(() => WishlistNetworkProvider());
  locator.registerLazySingleton<WishlistRepository>(() => WishlistRepository(
    apiService: locator.get<WishlistNetworkProvider>(),
    accountDatabaseService: locator.get<AccountDatabaseProvider>(),
  ));
  locator.registerLazySingleton<SearchNetworkProvider>(() => SearchNetworkProvider());
  locator.registerLazySingleton<SearchDatabaseProvider>(() => SearchDatabaseProvider(database.secureStorage));
  locator.registerLazySingleton<SearchRepository>(() => SearchRepository(
    apiService: locator.get<SearchNetworkProvider>(),
    searchDatabaseService: locator.get<SearchDatabaseProvider>(),
  ));
  locator.registerLazySingleton<CategoryNetworkProvider>(() => CategoryNetworkProvider());
  locator.registerLazySingleton<CategoryRepository>(() => CategoryRepository(
    apiService: locator.get<CategoryNetworkProvider>(),
  ));
  locator.registerLazySingleton<HomeNetworkProvider>(() => HomeNetworkProvider());
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository(
    apiService: locator.get<HomeNetworkProvider>(),
  ));

  locator.registerLazySingleton<CartNetworkProvider>(() => CartNetworkProvider());
  locator.registerLazySingleton<CartDatabaseProvider>(() => CartDatabaseProvider(database.secureStorage));
  locator.registerLazySingleton<CartRepository>(() => CartRepository(
    apiService: locator.get<CartNetworkProvider>(),
    databaseService: locator.get<CartDatabaseProvider>(),
    accountDatabaseService: locator.get<AccountDatabaseProvider>(),
  ));
  
  locator.registerLazySingleton<AddressNetworkProvider>(() => AddressNetworkProvider());
  locator.registerLazySingleton<AddressRepository>(() => AddressRepository(
    apiService: locator.get<AddressNetworkProvider>(),
    accountDatabaseService: locator.get<AccountDatabaseProvider>(),
  ));

  locator.registerLazySingleton<ProductNetworkProvider>(() => ProductNetworkProvider());
  locator.registerLazySingleton<ProductRepository>(() => ProductRepository(
    apiService: locator.get<ProductNetworkProvider>(),
  ));

  locator.registerLazySingleton<LocationService>(() => LocationService());
  locator.registerLazySingleton<LocationRepository>(() => LocationRepository(locationService: locator.get<LocationService>(),
  ));

  locator.registerLazySingleton<OrderNetworkProvider>(() => OrderNetworkProvider());
  locator.registerLazySingleton<OrderRepository>(() => OrderRepository(
    apiService: locator.get<OrderNetworkProvider>(),
    accountDatabaseService: locator.get<AccountDatabaseProvider>(),
  ));
}
