import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Address/blocs/address_bloc/address_bloc.dart';
import 'package:my_ecommerce/Address/blocs/location_bloc/location_bloc.dart';
import 'package:my_ecommerce/Address/data/repositories/address_repo.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';
import 'add_address_screen.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  late final GoogleMapController googleMapController;
  LatLng location = LatLng(30.0504132, 31.2073222);
  TextEditingController textController = TextEditingController();
  final LocationBloc locationBloc = LocationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      bloc: locationBloc,
      listener: (context, state) {
        if (state is LocationLoaded) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) => BlocProvider<AddressBloc>(
                      create: (context) => AddressBloc(),
                      child: AddAddressScreen(
                        locationAddress: state.location,
                      ),
                    )),
          );
        } else if (state is LocationError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                state.msg ?? '',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        } else if (state is LocationNoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                'No Internet Connection',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: const LatLng(30.0504132, 31.2073222),
                  zoom: 16,
                ),
                onMapCreated: (controller) {
                  googleMapController = controller;
                },
                onTap: (pos) {
                  googleMapController.animateCamera(CameraUpdate.newLatLng(
                    pos,
                  ));
                },
                onCameraMove: (cameraPos) {
                  location = cameraPos.target;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.PRIMARY_COLOR,
                        size: 30,
                      ),
                    ),
                    //const BackElvButton(),
                    Expanded(
                      child: TypeAheadField(
                        minCharsForSuggestions: 1,
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textFieldConfiguration: TextFieldConfiguration(
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            fillColor: Color(0xFFF6F6F6),
                            filled: true,
                            hintText: 'Search for location',
                            prefixIcon: Icon(Icons.search),
                          ),
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: textController,
                        ),
                        suggestionsCallback: (pattern) async {
                          final res = await locator
                              .get<AddressRepository>()
                              .getLoactionSearchResult(pattern);
                          return res.getOrElse(() => []);
                        },
                        autoFlipDirection: true,
                        hideOnEmpty: true,
                        hideOnError: true,
                        hideOnLoading: true,
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: Icon(Icons.location_on_rounded),
                            title: Text(suggestion.displayPlace),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          googleMapController
                              .animateCamera(CameraUpdate.newLatLng(
                            LatLng(suggestion.position.latitude,
                                suggestion.position.longitude),
                          ));
                          textController.text = suggestion.displayPlace;
                        },
                        keepSuggestionsOnLoading: false,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Icon(
                    Icons.location_on,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<LocationBloc, LocationState>(
            bloc: locationBloc,
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: state is LocationLoading
                    ? null
                    : () {
                        locationBloc
                            .add(FetchLocationAddress(position: location));
                      },
                child: state is LocationLoading
                    ? CircularProgressIndicator.adaptive()
                    : const Text('Choose Location'),
              );
            },
          ),
        ),
      ),
    );
  }
}
