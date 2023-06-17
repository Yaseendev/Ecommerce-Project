part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object?> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  final List<Product> products;

  PopularLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class PopularError extends PopularState {
  final String? msg;

  PopularError([this.msg]);

  @override
  List<Object?> get props => [msg];
}
