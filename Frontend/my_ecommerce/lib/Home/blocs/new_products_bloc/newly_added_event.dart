part of 'newly_added_bloc.dart';

abstract class NewlyAddedEvent extends Equatable {
  const NewlyAddedEvent();

  @override
  List<Object> get props => [];
}

class FetchNewlyAdded extends NewlyAddedEvent {
  
}