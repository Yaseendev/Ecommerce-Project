part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object> get props => [];
}

class LoadMostPopular extends PopularEvent {
  
}