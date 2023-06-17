import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Account/data/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class Urls {
  static const String DOMAIN = 'http://localhost:8080';
  static const String BASE_API = DOMAIN + '/api/v1';
  static const String AUTH_PATH = '/auth';
  static const String PRODUCT_PATH = '/products';
  static const String CART_PATH = '/cart';
  static const String WISHLIST_PATH = '/wishlist';
  static const String USER_PATH = '/user';
  static const String GET_CATEGORIES = '/categories';
  static const String ORDERS_PATH = '/orders';
  static const String COUPON_PATH = '/coupon';
  static const String SEARCH = '$PRODUCT_PATH/search';
  static const String SEARCH_FILTERED = '$PRODUCT_PATH/search-filtered';
  static const String DEAL_OF_DAY = '$PRODUCT_PATH/deal-of-day';
  static const String MOST_POPULAR = '$PRODUCT_PATH/most-popular';
  static const String TOP_RATED = '$PRODUCT_PATH/most-rated';
  static const String NEWLY_ADDED = '$PRODUCT_PATH/newly-added';
  static const String PRODUCTS_ADS = '$PRODUCT_PATH/ads';
  static const String PRODUCTS_BRANDS = '$PRODUCT_PATH/brands';
  static const String SIGNUP_API = '$AUTH_PATH/register';
  static const String SIGNIN_API = '$AUTH_PATH/signin';
  static const String TOKEN_CHECK_API = '$AUTH_PATH/token-check';
  static const String EDIT_USER = '$USER_PATH/edit';
  static const String GET_CART = '$CART_PATH/get-cart';
  static const String ADD_CART = '$CART_PATH/add';
  static const String ADD_CART_BULK = '$CART_PATH/add-all';
  static const String UPDATE_CART = '$CART_PATH/update';
  static const String REMOVE_CART = '$CART_PATH/remove';
  static const String GET_WISHLIST = '$WISHLIST_PATH/get';
  static const String ADD_WISHLIST = '$WISHLIST_PATH/add';
  static const String REMOVE_WISHLIST = '$WISHLIST_PATH/remove';
  static const String GET_ADDRESSES = '$USER_PATH/addresses';
  static const String ADD_ADDRESS = '$GET_ADDRESSES/add';
  static const String EDIT_ADDRESS = '$GET_ADDRESSES/edit';
  static const String DELETE_ADDRESS = '$GET_ADDRESSES/delete';
  static const String CHECKOUT = '$ORDERS_PATH/add';
  static const String GET_ORDERS = '$ORDERS_PATH/get';
  static const String CANCEL_ORDER = '$ORDERS_PATH/cancel';
  static const String REMOVE_COUP_CART = '$COUPON_PATH/remove';

  ///Location Urls
  static const String LOCATION_DOMAIN = 'https://eu1.locationiq.com';
  static const String LOCATION_BASE_API = LOCATION_DOMAIN + '/v1';
  static const String LOCATION_AUTOCOMPLETE = '/autocomplete.php';
  static const String LOCATION_REVERSE = '/reverse.php';
}

final String locationKey = dotenv.env['LOCATION_IQ_KEY'] ?? ''; //TODO: Add Your Api Key

class Boxes {
  static Future<Box<User>> getUserBox() async {
    if (Hive.isBoxOpen('userBox'))
      return Hive.box<User>('userBox');
    else
      return await Hive.openBox<User>('userBox');
  }

  static Future<Box<String>> getSearchBox() async {
    if (Hive.isBoxOpen('searchHistory'))
      return Hive.box<String>('searchHistory');
    else
      return await Hive.openBox<String>('searchHistory');
  }

    static Future<Box> getAppDataBox() async {
    if (Hive.isBoxOpen('appData'))
      return Hive.box('appData');
    else
      return await Hive.openBox('appData');
  }
}

class Images {
  static const String ROOT = 'assets/images';
  static const String DEFAULT_PROFILE = '$ROOT/default_profile.png';
  static const String LOGO = '$ROOT/logo.png';
  static const String LOGO_TRANSPARENT = '$ROOT/logo_transparent.png';
  static const String PLACEHOLDER = '$ROOT/placeholder.jpg';
  static const String NOT_LOGGEDIN = '$ROOT/no_login.jpeg';
  static const String NO_INTERNET = '$ROOT/no-wifi.png';
  static const String WISHLIST = '$ROOT/wishlist.png';
  static const String NO_LOGIN = '$ROOT/login-svg.svg';
  static const String EMPTY_CART = '$ROOT/empty_cart.png';
}

class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFF374151);
  static const Color BACKGROUND_COLOR = Color(0xFFF7F8F9); //Color(0xFFDEDEDE);
  static const Color SECONDARY_COLOR = Color(0xFFDEDEDE);
  // ignore: non_constant_identifier_names
  static final MaterialColor PRIMARY_SWATCH =
      MaterialColor(AppColors.PRIMARY_COLOR.value, <int, Color>{
    50: PRIMARY_COLOR,
    100: PRIMARY_COLOR,
    200: PRIMARY_COLOR,
    300: PRIMARY_COLOR,
    400: PRIMARY_COLOR,
    500: PRIMARY_COLOR,
    600: PRIMARY_COLOR,
    700: PRIMARY_COLOR,
    800: PRIMARY_COLOR,
    900: PRIMARY_COLOR,
  });
}
