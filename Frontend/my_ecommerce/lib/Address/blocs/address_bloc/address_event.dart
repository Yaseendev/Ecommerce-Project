part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class EditAddress extends AddressEvent {
  final int index;
  final Address address;
  EditAddress({
    required this.address,
    required this.index,
  });

  @override
  List<Object> get props => [address, index];
}

class AddAddress extends AddressEvent {
  final Address address;

  AddAddress({
    required this.address,
  });

  @override
  List<Object> get props => [address];
}

class DeleteAddress extends AddressEvent {
  final int id;

  DeleteAddress({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
