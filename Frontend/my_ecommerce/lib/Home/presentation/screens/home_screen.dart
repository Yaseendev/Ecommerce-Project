import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:my_ecommerce/Home/blocs/new_products_bloc/newly_added_bloc.dart';
import 'package:my_ecommerce/Home/blocs/popular_bloc/popular_bloc.dart';
import 'package:my_ecommerce/Home/blocs/products_ads_bloc/products_ads_bloc.dart';
import 'package:my_ecommerce/Home/blocs/top_products_bloc/top_products_bloc.dart';
import 'package:my_ecommerce/Home/presentation/widgets/most_popular_section.dart';
import 'package:my_ecommerce/Home/presentation/widgets/top_rated_view.dart';
import 'package:my_ecommerce/Primary/blocs/categories_bloc/categories_bloc.dart';
import 'package:my_ecommerce/Search/presentation/widgets/search_box.dart';
import '../widgets/address_box.dart';
import '../widgets/banner_view.dart';
import '../widgets/categories_view.dart';
import '../widgets/newly_added_view.dart';

class HomeScreen extends StatelessWidget {
  final Function(String term) onSearch;
  const HomeScreen({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: SearchBox(
          onController: (controller) {},
          onPress: (value) {
            onSearch(value);
          },
          initialVal: '',
        ),
        bottom: AddressBox(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
            ..read<ProductsAdsBloc>().add(FetchAds())
            ..read<CategoriesBloc>().add(LoadCategories())
            ..read<NewlyAddedBloc>().add(FetchNewlyAdded())
            ..read<TopProductsBloc>().add(FetchTopRated())
            ..read<PopularBloc>().add(LoadMostPopular());
          return Future.delayed(Duration(milliseconds: 400))
              .then((value) => true);
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            const BannerView(),
            const CategoriesView(),
            const NewlyAddedView(),
            const TopRatedView(),
            const MostPopularSection(),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
