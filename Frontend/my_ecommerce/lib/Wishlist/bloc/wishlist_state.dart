part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  final List<Product>? products;
  const WishlistState([this.products]);

  @override
  List<Object?> get props => [products];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial(super.products);
}

class WishlistLoading extends WishlistState {
  final String? productId;

  const WishlistLoading(super.products, [this.productId]);

  @override
  List<Object?> get props => [productId];
}

class WishlistNoInternet extends WishlistState {
  const WishlistNoInternet(super.products);
}

class WishlistError extends WishlistState {
  final String? msg;

  WishlistError(super.products,[this.msg = 'Something went wrong']);

  @override
  List<Object?> get props => [msg];
}

class WishlistLoaded extends WishlistState {
  final List<Product> products;

  WishlistLoaded(this.products) : super(products);

  @override
  List<Object?> get props => [products];
}
