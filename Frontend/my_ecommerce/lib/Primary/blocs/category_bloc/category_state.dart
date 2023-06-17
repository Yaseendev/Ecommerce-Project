part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Product> products;
  final String? searchTerm;

  CategoryLoaded({required this.products,
  this.searchTerm,
  });

  @override
  List<Object?> get props => [products, searchTerm];
}
