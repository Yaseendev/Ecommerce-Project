import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Address/data/models/location_address.dart';
import 'package:my_ecommerce/Address/data/repositories/address_repo.dart';
import 'package:my_ecommerce/Address/data/repositories/location_repository.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AddressRepository _addressRepository =
        locator.get<AddressRepository>();
    final LocationRepository locationRepository =
        locator.get<LocationRepository>();

    on<FetchLocationAddress>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(LocationLoading());
        await _addressRepository
            .getLocationAddress(event.position)
            .then((value) => value
                    .fold((left) => emit(LocationError(left.message)), (right) {
                  emit(LocationLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(LocationError(error.toString()));
        });
      } else {
        emit(LocationNoInternet());
      }
    });

    on<DetectCurrentLocation>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        try {
          final Position? position = await locationRepository.getCurrentPosition();
          if (position != null) {
            await _addressRepository
                .getLocationAddress(LatLng(position.latitude, position.longitude))
                .then((res) => res.fold(
                  (l) => emit(LocationError()),
                  (location) => emit(LocationLoaded(location))))
                .onError((error, stackTrace) => emit(LocationError()));
          } else {
            emit(LocationError());
          }
        } catch (e) {
          emit(LocationError());
        }
      } else {
        emit(LocationError());
      }
    });
  }
}
