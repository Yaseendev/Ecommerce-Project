part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationNoInternet extends LocationState {}

class LocationError extends LocationState {
  final String? msg;

  LocationError([this.msg]);

  @override
  List<Object?> get props => [msg];
}

class LocationLoaded extends LocationState {
  final LocationAddress location;
  LocationLoaded(this.location);

  @override
  List<Object?> get props => [location];
}
