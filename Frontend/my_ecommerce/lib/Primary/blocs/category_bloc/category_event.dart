part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategory extends CategoryEvent {
  final String categoryId;
  
  LoadCategory({
    required this.categoryId,
  });

  @override
  List<Object> get props => [categoryId];
}

class FillterProducts extends CategoryEvent {
  final String searchTerm;
  
  FillterProducts({
    required this.searchTerm,
  });

  @override
  List<Object> get props => [searchTerm];
}
