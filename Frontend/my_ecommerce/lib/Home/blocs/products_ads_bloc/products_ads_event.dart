part of 'products_ads_bloc.dart';

abstract class ProductsAdsEvent extends Equatable {
  const ProductsAdsEvent();

  @override
  List<Object> get props => [];
}

class FetchAds extends ProductsAdsEvent {
  
}