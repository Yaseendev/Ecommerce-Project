part of 'addresses_bloc.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();
  
  @override
  List<Object?> get props => [];
}

class AddressesInitial extends AddressesState {}

class AddressesLoading extends AddressesState {}

class AddressesNoInternet extends AddressesState {}

class AddressesFetched extends AddressesState {
  final List<Address> addresses;
  final Address? selectedAddress;

  AddressesFetched({
   required this.addresses,
   required this.selectedAddress,
   });

  @override
  List<Object?> get props => [addresses, selectedAddress];

  AddressesFetched copyWith({
    List<Address>? addresses,
    Address? selectedAddress,
  }) {
    return AddressesFetched(
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}

class AddressesError extends AddressesState {
  final String? msg;

  AddressesError([this.msg]);

  @override
  List<Object?> get props => [msg];
}