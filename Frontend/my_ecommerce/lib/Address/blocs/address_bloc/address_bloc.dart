import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Address/data/models/address.dart';
import 'package:my_ecommerce/Address/data/repositories/address_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AddressRepository _addressRepository =
        locator.get<AddressRepository>();

    on<EditAddress>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressLoading());
        await _addressRepository.editAddress(event.address, event.index).then((res) {
          res.fold((left) => emit(AddressError(left.message)), (right) {
            emit(AddressUpdated(
              addresses: right,
            ));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(AddressError(error.toString()));
        });
      } else {
        emit(AddressNoInternet());
      }
    });

    on<AddAddress>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressLoading());
        await _addressRepository
            .addAddress(event.address)
            .then((res) {
          res.fold((left) => emit(AddressError(left.message)), (right) {
            emit(AddressAdded(addresses: right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(AddressError(error.toString()));
        });
      } else {
        emit(AddressNoInternet());
      }
    });

    on<DeleteAddress>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AddressLoading());
        await _addressRepository.deleteAddress(event.id).then((res) {
          res.fold((left) => emit(AddressError(left.message)), (right) {
           emit(AddressUpdated(addresses: right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(AddressError(error.toString()));
        });
      } else {
        emit(AddressNoInternet());
      }
    });
  }
}
