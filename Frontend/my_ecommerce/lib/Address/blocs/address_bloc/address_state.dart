part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressUpdated extends AddressState {
  final List<Address> addresses;

  const AddressUpdated({
    required this.addresses,
  });

  @override
  List<Object?> get props => [addresses];
}

class AddressAdded extends AddressState {
  final List<Address> addresses;

  AddressAdded({
    required this.addresses,
  });

  @override
  List<Object?> get props => [addresses];
}

class AddressLoading extends AddressState {}

class AddressNoInternet extends AddressState {}

class AddressError extends AddressState {
  final String? msg;

  AddressError([this.msg]);

  @override
  List<Object?> get props => [msg];
}
