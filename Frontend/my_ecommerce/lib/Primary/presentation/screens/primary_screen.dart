import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/presentation/screens/account_screen.dart';
import 'package:my_ecommerce/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:my_ecommerce/Address/blocs/location_bloc/location_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:my_ecommerce/Cart/presentation/screens/cart_screen.dart';
import 'package:my_ecommerce/Home/blocs/new_products_bloc/newly_added_bloc.dart';
import 'package:my_ecommerce/Home/blocs/popular_bloc/popular_bloc.dart';
import 'package:my_ecommerce/Home/blocs/products_ads_bloc/products_ads_bloc.dart';
import 'package:my_ecommerce/Home/blocs/top_products_bloc/top_products_bloc.dart';
import 'package:my_ecommerce/Home/presentation/screens/home_screen.dart';
import 'package:my_ecommerce/Order/blocs/order_bloc/order_bloc.dart';
import 'package:my_ecommerce/Primary/blocs/categories_bloc/categories_bloc.dart';
import 'package:my_ecommerce/Search/blocs/filter_bloc/filter_bloc.dart';
import 'package:my_ecommerce/Search/blocs/search_bloc/search_bloc.dart';
import 'package:my_ecommerce/Search/presentation/screens/search_screen.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Wishlist/bloc/wishlist_bloc.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen>
    with TickerProviderStateMixin {
  late final TabController controller;
  int currentIndex = 0;
  final Map<String, Widget> screens = {};
  final SearchBloc _searchBloc = SearchBloc()..add(FetchSearchHistory());
   final LocationBloc locationBloc = LocationBloc()
    ..add(DetectCurrentLocation());
  @override
  void initState() {
    screens.addAll({
      'Home': HomeScreen(
        onSearch: (term) {
          screens.update(
              'Search',
              (widget) => SearchScreen(
                    searchTerm: term,
                  ));

          _searchBloc.add(FetchSearchData(searchTxt: term));
          goToPage(1);
        },
      ),
      'Search': const SearchScreen(),
      'Cart': CartScreen(
        fromHome: true,
      ),
      'More': const AccountScreen(),
    });
    controller = TabController(length: 4, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoriesBloc>().add(LoadCategories());
      context.read<FilterBloc>().add(FetchFilterData());
      context.read<WishlistBloc>().add(GetWishList());
      context.read<CartBloc>().add(GetCart());
      context.read<AddressesBloc>().add(GetAllAddresses());
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartBloc>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context) => locationBloc,
        ),
        BlocProvider<NewlyAddedBloc>(
          create: (context) => NewlyAddedBloc()..add(FetchNewlyAdded()),
        ),
        BlocProvider<TopProductsBloc>(
          create: (context) => TopProductsBloc()..add(FetchTopRated()),
        ),
        BlocProvider<PopularBloc>(
          create: (context) => PopularBloc()..add(LoadMostPopular()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => _searchBloc,
        ),
        BlocProvider<ProductsAdsBloc>(
          create: (context) => ProductsAdsBloc()..add(FetchAds()),
        ),
        
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: currentIndex < 2
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  screens.keys.elementAt(currentIndex),
                  style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8.0),
                    child: CircleAvatar(
                      child: Icon(Icons.person_rounded),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ],
              )
            : null,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: TabBarView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: screens.values.toList(),
          ),
        ),
        floatingActionButton: CustomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          borderRadius: const Radius.circular(14),
          iconSize: 30,
          strokeColor: AppColors.SECONDARY_COLOR,
          selectedColor: AppColors.SECONDARY_COLOR,
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_rounded),
              title: Text(
                'Home',
                style: TextStyle(
                  color: currentIndex == 0
                      ? AppColors.SECONDARY_COLOR
                      : Colors.grey,
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.search_outlined),
              selectedIcon: const Icon(Icons.search_rounded),
              title: Text(
                'Search',
                style: TextStyle(
                  color: currentIndex == 1
                      ? AppColors.SECONDARY_COLOR
                      : Colors.grey,
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              selectedIcon: const Icon(Icons.shopping_cart_rounded),
              title: Text(
                'Cart',
                style: TextStyle(
                  color: currentIndex == 2
                      ? AppColors.SECONDARY_COLOR
                      : Colors.grey,
                ),
              ),
              badgeCount: cartState is CartLoaded
                  ? cartState.cart.cartContent.length
                  : 0,
              showBadge: cartState is CartLoaded &&
                  cartState.cart.cartContent.isNotEmpty,
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.more_horiz_outlined),
              selectedIcon: const Icon(Icons.more_horiz),
              title: Text(
                'More',
                style: TextStyle(
                  color: currentIndex == 3
                      ? AppColors.SECONDARY_COLOR
                      : Colors.grey,
                ),
              ),
            ),
          ],
          isFloating: true,
          currentIndex: currentIndex,
          onTap: (index) {
            goToPage(index);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (currentIndex == 0) {
      return Future.value(true);
    } else {
      goToPage(0);
      return Future.value(false);
    }
  }

  Future<void> goToPage(int page) async {
    controller.animateTo(page);
    setState(() {
      currentIndex = page;
    });
  }
}
