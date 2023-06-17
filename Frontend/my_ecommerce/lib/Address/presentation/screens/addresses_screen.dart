import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:my_ecommerce/Shared/widgets/error_view.dart';
import 'package:my_ecommerce/Shared/widgets/no_internet_view.dart';
import 'package:my_ecommerce/Utils/constants.dart';

import '../widgets/add_address_button.dart';
import '../widgets/address_card.dart';
import '../widgets/addresses_loading_view.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesBloc, AddressesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            centerTitle: true,
            title: Text(
              'Your Addresses',
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
              ),
            ),
            leading: BackButton(
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: state is AddressesLoading
                      ? AddressesLoadingView()
                      : state is AddressesFetched
                          ? state.addresses.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Saved Addresses',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: state.addresses.length,
                                  itemBuilder: (context, index) {
                                    return AddressCard(
                                      index: index,
                                      address: state.addresses[index],
                                        );
                                  },
                                )
                          : state is AddressesError
                              ? ErrorView(errorTxt: state.msg)
                              : state is AddressesNoInternet
                                  ? const NoInternetView()
                                  : Container(),
                ),
                state is AddressesFetched ? const AddAddressButton() : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
