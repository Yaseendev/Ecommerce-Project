part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchRelatedProducts extends ProductEvent {
  final Product product;

  FetchRelatedProducts({
   required this.product,
   });

  @override
  List<Object> get props => [product];
}
