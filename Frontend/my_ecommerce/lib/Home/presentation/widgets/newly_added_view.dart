import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:my_ecommerce/Home/blocs/new_products_bloc/newly_added_bloc.dart';
import 'package:my_ecommerce/Product/presentation/screens/product_screen.dart';
import 'package:my_ecommerce/Shared/widgets/open_container_wrapper.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../screens/home_products_screen.dart';
import 'loading/product_home_h_loading_card.dart';
import 'product_home_card_h.dart';

class NewlyAddedView extends StatelessWidget {
  const NewlyAddedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewlyAddedBloc, NewlyAddedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            state is NewlyAddedLoaded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Newly Arrived',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => HomeProductsScreen(
                                    title: 'Newly Arrived',
                                    products: state.products,
                                  )));
                        },
                        child: const Text('See All'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: AppColors.PRIMARY_COLOR,
                        ),
                      ),
                    ],
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 18,
                      width: 95,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: state is NewlyAddedLoaded
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state is NewlyAddedLoaded
                    ? state.products
                        .map((e) => OpenContainerWrapper(
                              transitionType: ContainerTransitionType.fade,
                              closedBuilder: (context, action) =>
                                  ProductHomeHCard(
                                product: e,
                                openContainer: action,
                              ),
                              openWidget: BlocProvider<CouponBloc>(
                                create: (_) => context.read<CouponBloc>(),
                                child: ProductScreen(
                                  product: e,
                                ),
                              ),
                            ))
                        .toList()
                    : List.filled(5, ProductHomeHLoadingCard()),
              ),
            ),
          ],
        );
      },
    );
  }
}
