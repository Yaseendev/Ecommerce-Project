import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:my_ecommerce/Home/blocs/products_ads_bloc/products_ads_bloc.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'loading/ads_view_loading.dart';

class BannerView extends StatelessWidget {
  const BannerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsAdsBloc, ProductsAdsState>(
      builder: (context, state) {
        return state is ProductsAdsLoaded
            ? ImageSlideshow(
          autoPlayInterval: 3000,
          height: 160,
          isLoop: true,
          children: state.ads.map((ad) => ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: FadeInImage.assetNetwork(
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                  Images.PLACEHOLDER,
                  fit: BoxFit.fill,
                ),
                placeholder: Images.PLACEHOLDER,
                image: ad,
                fit: BoxFit.fill,
              ),
            )).toList(),
        ) : const AdsViewLoading();
      },
    );
  }
}
