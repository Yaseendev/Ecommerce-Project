import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Address/blocs/address_bloc/address_bloc.dart';
import 'package:my_ecommerce/Address/data/models/address.dart';

import '../screens/edit_address_screen.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final int index;
  const AddressCard({
    super.key,
    required this.address,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BlocProvider<AddressBloc>(
                create: (context) => AddressBloc(),
                child: EditAddressScreen(
                  address: address,
                  index: index,
                ),
              ))),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.label!.isEmpty
                    ? '${address.street}, ${address.city}'
                    : '${address.label}(${address.street}, ${address.city})',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                  'Floor: ${address.floorNumber!.isEmpty ? 'n/a' : address.floorNumber}, Block/Area: ${address.blockNumber}'),
              SizedBox(height: 5),
              Text('Phone Number: ${address.phone}'),
            ],
          ),
        ),
      ),
    );
  }
}
