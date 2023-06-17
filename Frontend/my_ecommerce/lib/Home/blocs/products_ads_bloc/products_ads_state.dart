part of 'products_ads_bloc.dart';

abstract class ProductsAdsState extends Equatable {
  const ProductsAdsState();
  
  @override
  List<Object?> get props => [];
}

class ProductsAdsInitial extends ProductsAdsState {}

class ProductsAdsLoading extends ProductsAdsState {}

class ProductsAdsLoaded extends ProductsAdsState {
  final List<String> ads;

   ProductsAdsLoaded({required this.ads});

  @override
  List<Object?> get props => [ads];
}

class ProductsAdsError extends ProductsAdsState {
  final String? msg;

  ProductsAdsError([this.msg]);

  @override
  List<Object?> get props => [msg];
}