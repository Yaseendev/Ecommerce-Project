import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Address/data/models/address.dart';
import 'package:my_ecommerce/Address/data/repositories/address_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(AddressesInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AddressRepository _addressRepository =
        locator.get<AddressRepository>();
    final List<Address> _addresses = [];
    Address? selectedAddress;

    on<GetAllAddresses>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressesLoading());
        await _addressRepository
            .fetchAddresses()
            .then((res) =>
                res.fold((left) => emit(AddressesError(left.message)), (right) {
                  _addresses
                    ..clear()
                    ..addAll(right);
                  if (_addresses.isNotEmpty) selectedAddress = right.first;
                  emit(AddressesFetched(
                    addresses: right,
                    selectedAddress: selectedAddress,
                  ));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(AddressesError(error.toString()));
        });
      } else {
        emit(AddressesNoInternet());
      }
    });

    on<UpdateAddresses>((event, emit) {
      emit(AddressesLoading());
      _addresses
        ..clear()
        ..addAll(event.addresses);
      if (_addresses.isNotEmpty && selectedAddress == null)
        selectedAddress = event.addresses.first;
      emit(AddressesFetched(
        addresses: event.addresses,
        selectedAddress: selectedAddress,
      ));
    });

    on<SetSelectedAddress>((event, emit) {
      // _addresses.clear();
      selectedAddress = event.address;
      emit( (state as AddressesFetched).copyWith
        (
        selectedAddress: selectedAddress,
      ));    });

    on<Reset>((event, emit) {
      _addresses.clear();
      selectedAddress = null;
      emit(AddressesInitial());
    });
  }
}
