// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addresses_bloc.dart';

abstract class AddressesEvent extends Equatable {
  const AddressesEvent();

  @override
  List<Object> get props => [];
}

class GetAllAddresses extends AddressesEvent {}

class UpdateAddresses extends AddressesEvent {
  final List<Address> addresses;

  UpdateAddresses({
    required this.addresses,
  });

  @override
  List<Object> get props => [addresses];
}

class Reset extends AddressesEvent {}

class SetSelectedAddress extends AddressesEvent {
  final Address address;

  SetSelectedAddress(this.address);

  @override
  List<Object> get props => [address];
}
