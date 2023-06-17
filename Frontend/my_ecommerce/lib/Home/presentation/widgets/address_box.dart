import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:my_ecommerce/Utils/constants.dart';

import 'current_location_text.dart';

class AddressBox extends StatelessWidget implements PreferredSizeWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressesBloc, AddressesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: state is AddressesFetched &&
                  state.addresses.isNotEmpty &&
                  state.selectedAddress != null
              ? () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14),
                    )),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .6,
                    ),
                    builder: (context) {
                      return BottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(14),
                        )),
                        onClosing: () {},
                        builder: (context) {
                          return ListView(
                            padding: const EdgeInsets.all(16),
                            children: [
                              Text(
                                'Choose Delivery Location',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...ListTile.divideTiles(
                                context: context,
                                tiles: state.addresses.isNotEmpty
                                    ? state.addresses.map((address) {
                                        return ListTile(
                                          leading: Icon(
                                            Icons.location_on,
                                            size: 28,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          title: Text(
                                            address.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                              'Floor: ${address.floorNumber}, Block: ${address.blockNumber}'),
                                          trailing: address ==
                                                  state.selectedAddress
                                              ? Icon(
                                                  Icons.check_circle_rounded,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              : null,
                                          contentPadding: EdgeInsets.zero,
                                          horizontalTitleGap: 0,
                                          onTap: () =>
                                              Navigator.pop(context, address),
                                        );
                                      })
                                    : [],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      context
                          .read<AddressesBloc>()
                          .add(SetSelectedAddress(value));
                    }
                  });
                }
              : null,
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: AppColors.PRIMARY_COLOR,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: [
                        Text(
                          'Deliver to ',
                          style: TextStyle(
                            color: AppColors.PRIMARY_COLOR, //Colors.white,
                          ),
                        ),
                        state is AddressesFetched &&
                                state.addresses.isNotEmpty &&
                                state.selectedAddress != null
                            ? Text(state.selectedAddress!.toString())
                            : CurrentLocationText(),
                      ],
                    ),
                  ),
                ),
                if (state is AddressesFetched &&
                    state.addresses.isNotEmpty &&
                    state.selectedAddress != null)
                  const Padding(
                    padding: EdgeInsets.only(left: 5, top: 2, right: 5),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
