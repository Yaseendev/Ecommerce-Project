part of 'newly_added_bloc.dart';

abstract class NewlyAddedState extends Equatable {
  const NewlyAddedState();
  
  @override
  List<Object?> get props => [];
}

class NewlyAddedInitial extends NewlyAddedState {}

class NewlyAddedLoading extends NewlyAddedState {}

class NewlyAddedLoaded extends NewlyAddedState {
  final List<Product> products;

  NewlyAddedLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class NewlyAddedError extends NewlyAddedState {
  final String? msg;

    NewlyAddedError([this.msg]);

  @override
  List<Object?> get props => [msg];
}