import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Address/blocs/address_bloc/address_bloc.dart';
import 'package:my_ecommerce/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:my_ecommerce/Address/data/models/address.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import '../widgets/address_form.dart';
import '../widgets/location_card.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;
  final int index;

  const EditAddressScreen({
    super.key,
    required this.address,
    required this.index,
  });

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressUpdated) {
          context.read<AddressesBloc>().add(UpdateAddresses(
                addresses: state.addresses,
              ));
          Navigator.pop(context);
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
            'Edit Address',
            style: TextStyle(
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          leading: BackButton(
            color: AppColors.PRIMARY_COLOR,
          ),
          actions: [
            TextButton.icon(
              onPressed: context.watch<AddressBloc>().state is AddressLoading
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            title: Text('Delete Address'),
                            content: Text(
                                'Are you sure you want to delete this address?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      ).then((value) {
                        if (value != null && value) {
                          context
                              .read<AddressBloc>()
                              .add(DeleteAddress(id: widget.index));
                        }
                      });
                    },
              label: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            LocationCard(
              location: widget.address.position,
            ),
            const SizedBox(height: 20),

            ///Address from
            AddressForm(
                city: widget.address.city,
                street: widget.address.street,
                block: widget.address.blockNumber,
                floor: widget.address.floorNumber ?? '',
                phone: widget.address.phone,
                label: 'Edit Address',
                initLocation: widget.address.position,
                addtioinalInfo: widget.address.additionalInfo ?? '',
                apartmentNumber: widget.address.apartmentNumber ?? '',
                building: widget.address.buildingName,
                addressLabel: widget.address.label,
                onPress: (address) {
                  context.read<AddressBloc>().add(EditAddress(
                        index: widget.index,
                        address: address,
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
