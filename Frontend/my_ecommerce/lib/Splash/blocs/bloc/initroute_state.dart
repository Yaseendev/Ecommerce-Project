// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'initroute_bloc.dart';

abstract class InitrouteState extends Equatable {
  const InitrouteState();

  @override
  List<Object> get props => [];
}

class InitrouteInitial extends InitrouteState {}

class InitrouteError extends InitrouteState {
  @override
  List<Object> get props => [];
}

class InitrouteInValidToken extends InitrouteState {
  @override
  List<Object> get props => [];
}

class InitrouteNoToken extends InitrouteState {
  @override
  List<Object> get props => [];
}

class InitrouteNoInternet extends InitrouteState {
  @override
  List<Object> get props => [];
}

class InitrouteValidToken extends InitrouteState {
  final User user;

  InitrouteValidToken({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
