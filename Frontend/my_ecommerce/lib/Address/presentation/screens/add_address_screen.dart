import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Address/blocs/address_bloc/address_bloc.dart';
import 'package:my_ecommerce/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:my_ecommerce/Address/data/models/location_address.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import '../widgets/address_form.dart';
import '../widgets/location_card.dart';

class AddAddressScreen extends StatefulWidget {
  final LocationAddress locationAddress;
  const AddAddressScreen({
    super.key,
    required this.locationAddress,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressAdded) {
          Navigator.pop(context);
          context.read<AddressesBloc>().add(UpdateAddresses(addresses: state.addresses));
        } else if (state is AddressNoInternet) {
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
        } else if (state is AddressError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                state.msg ?? 'Something went wrong',
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Add Address',
            style: TextStyle(
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          leading: BackButton(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            LocationCard(
              location: widget.locationAddress.location,
            ),
            SizedBox(height: 20),

            ///Address from
            AddressForm(
              label: 'Add Address',
              street: widget.locationAddress.street,
              initLocation: widget.locationAddress.location,
              block: widget.locationAddress.area,
              city: widget.locationAddress.city,
              onPress: (address) {
                context.read<AddressBloc>().add(AddAddress(address: address));
              },
            ),
          ],
        ),
      ),
    );
  }
}
