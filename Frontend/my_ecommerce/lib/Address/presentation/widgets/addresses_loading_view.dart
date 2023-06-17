import 'package:flutter/material.dart';

import 'address_loading_card.dart';

class AddressesLoadingView extends StatelessWidget {
  const AddressesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: List.filled(6, AddressLoadingCard()),
    );
  }
}
