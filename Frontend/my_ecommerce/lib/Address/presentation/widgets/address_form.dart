import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Address/blocs/address_bloc/address_bloc.dart';
import 'package:my_ecommerce/Address/data/models/address.dart';

class AddressForm extends StatefulWidget {
  final String city;
  final String street;
  final String block;
  final String floor;
  final String phone;
  final Function(Address address) onPress;
  final String label;
  final String? addressLabel;
  final String building;
  final String apartmentNumber;
  final String addtioinalInfo;
  final LatLng initLocation;
  const AddressForm({
    super.key,
    this.city = '',
    this.block = '',
    this.floor = '',
    this.phone = '',
    this.street = '',
    required this.onPress,
    required this.label,
    this.addtioinalInfo = '',
    this.apartmentNumber = '',
    this.building = '',
    required this.initLocation,
    this.addressLabel,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String city = '';
  String street = '';
  String block = '';
  String floor = '';
  String phone = '';
  String label = '';
  String building = '';
  String apartmentNumber = '';
  String addtioinalInfo = '';

  @override
  void initState() {
    city = widget.city;
    street = widget.street;
    block = widget.block;
    floor = widget.floor;
    phone = widget.phone;
    label = widget.addressLabel ?? '';
    building = widget.building;
    apartmentNumber = widget.apartmentNumber;
    addtioinalInfo = widget.addtioinalInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              hintText: 'My Appartment, My Office...',
              labelText: 'Address Label (optional)',
              prefixIcon: const Icon(Icons.label_rounded),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            onChanged: (value) => label = value.trimLeft(),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              hintText: 'City',
              labelText: 'City',
              prefixIcon: const Icon(Icons.location_city_rounded),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            initialValue: city,
            onChanged: (value) => city = value,
            validator: (value) {
              return value!.trim().isEmpty ? 'This field is required' : null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              hintText: 'Street Name',
              labelText: 'Street Name',
              prefixIcon: const Icon(Icons.grid_goldenratio_rounded),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            initialValue: street,
            onChanged: (value) => street = value.trim(),
            validator: (value) {
              return value!.trim().isEmpty ? 'This field is required' : null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              hintText: 'Block/Area Number',
              labelText: 'Block Number',
              prefixIcon: const Icon(Icons.grid_view_rounded),
            ),
            textInputAction: TextInputAction.next,
            maxLines: 1,
            initialValue: block,
            onChanged: (value) => block = value.trim(),
            validator: (value) {
              return value!.trim().isEmpty ? 'This field is required' : null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              hintText: 'Building Name',
              labelText: 'Building Name',
              prefixIcon: const Icon(Icons.domain_rounded),
            ),
            textInputAction: TextInputAction.next,
            maxLines: 1,
            initialValue: floor,
            onChanged: (value) => building = value.trim(),
            validator: (value) {
              return value!.trim().isEmpty ? 'This field is required' : null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              hintText: 'Floor',
              labelText: 'Floor (optional)',
              prefixIcon: const Icon(Icons.menu_rounded),
            ),
            textInputAction: TextInputAction.next,
            maxLines: 1,
            initialValue: floor,
            onChanged: (value) => floor = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              hintText: 'Apartment Number',
              labelText: 'Apartment Number (optional)',
              prefixIcon: const Icon(Icons.home_rounded),
            ),
            textInputAction: TextInputAction.next,
            maxLines: 1,
            initialValue: apartmentNumber,
            onChanged: (value) => apartmentNumber = value.trim(),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              hintText: 'Additional Description',
              labelText: 'Additional Description (optional)',
              prefixIcon: const Icon(Icons.description_rounded),
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            initialValue: addtioinalInfo,
            onChanged: (value) => addtioinalInfo = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
              ),
              prefixIcon: const Icon(Icons.phone),
              prefix: Localizations.localeOf(context).languageCode == 'en'
                  ? const Text(
                      '+20-',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
              suffix: Localizations.localeOf(context).languageCode == 'en'
                  ? null
                  : const Text(
                      '+20',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                    ),
              hintText: 'Phone Number',
              labelText: 'Phone Number',
            ),
            maxLines: 1,
            maxLength: 11,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            textInputAction: TextInputAction.next,
            initialValue: phone,
            onChanged: (value) => phone = value,
            validator: (value) {
              return value!.trim().isNotEmpty
                  ? int.tryParse(value.trim()) == null
                      ? 'Phone number is invalid'
                      : null
                  : 'This field is required';
            },
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: state is! AddressLoading
                        ? () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              widget.onPress(Address(
                                position: widget.initLocation,
                                city: city,
                                street: street,
                                phone: phone,
                                buildingName: building,
                                additionalInfo: addtioinalInfo,
                                apartmentNumber: apartmentNumber,
                                blockNumber: block,
                                floorNumber: floor,
                                label: label,
                              ));
                            }
                          }
                        : null,
                    child: state is! AddressLoading
                        ? Text(widget.label)
                        : Center(child: CircularProgressIndicator.adaptive()),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
