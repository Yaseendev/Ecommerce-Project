import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:my_ecommerce/Address/data/models/address.dart';
import 'package:my_ecommerce/Address/presentation/screens/location_selection_screen.dart';
import 'package:my_ecommerce/Cart/blocs/cart_bloc/cart_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Order/blocs/checkout_bloc/checkout_bloc.dart';
import 'package:my_ecommerce/Order/blocs/order_bloc/order_bloc.dart';
import 'package:my_ecommerce/Order/blocs/orders_bloc/orders_bloc.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:my_ecommerce/Order/presentations/screens/orders_screens.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/enums.dart';
import '../widgets/paywith_listview.dart';
import 'package:intl/intl.dart' as intl;

class CheckoutScreen extends StatefulWidget {
  final Cart cart;
  const CheckoutScreen({
    super.key,
    required this.cart,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod selectedMethod = PaymentMethod.cash;
  Address? selectedAddress;
  String notes = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Checkout',
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          color: AppColors.PRIMARY_COLOR,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Column(
            children: [
              BlocBuilder<AddressesBloc, AddressesState>(
                builder: (context, state) {
                  if (state is AddressesFetched) {
                    if (state.addresses.isNotEmpty) {
                      selectedAddress = state.selectedAddress;
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .16,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(14),
                                ),
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: state.selectedAddress!.position,
                                    zoom: 18,
                                  ),
                                  compassEnabled: false,
                                  mapToolbarEnabled: false,
                                  myLocationButtonEnabled: false,
                                  liteModeEnabled: Platform.isAndroid,
                                  scrollGesturesEnabled: false,
                                  rotateGesturesEnabled: false,
                                  zoomControlsEnabled: false,
                                  zoomGesturesEnabled: false,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.person_pin_circle_outlined),
                              title: Text(state.selectedAddress!.label!.isEmpty
                                  ? '${state.selectedAddress?.street}, ${state.selectedAddress?.city}'
                                  : '${state.selectedAddress?.label}(${state.selectedAddress?.street}, ${state.selectedAddress?.city})'),
                              subtitle: Text(state.selectedAddress!.phone),
                              trailing: TextButton(
                                child: Text('Change'),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(14),
                                    )),
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              .6,
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
                                                tiles: state.addresses
                                                    .map((address) {
                                                  return ListTile(
                                                    leading: Icon(
                                                      Icons.location_on,
                                                      size: 28,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    title: Text(
                                                      address.label!.isEmpty
                                                          ? '${address.street}, ${address.city}'
                                                          : '${address.label}(${address.street}, ${address.city})',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    subtitle: Text(
                                                        'Floor: ${address.floorNumber!.isEmpty ? 'n/a' : address.floorNumber}, Block/Area: ${address.blockNumber}'),
                                                    trailing: address ==
                                                            state
                                                                .selectedAddress
                                                        ? Icon(
                                                            Icons
                                                                .check_circle_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          )
                                                        : null,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    horizontalTitleGap: 0,
                                                    onTap: () => Navigator.pop(
                                                        context, address),
                                                  );
                                                }),
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
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: ListTile(
                          leading: Icon(Icons.add_rounded),
                          title: Text('Add Address'),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => LocationSelectionScreen())),
                        ),
                      );
                    }
                  } else
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: ListTile(
                        leading: CircularProgressIndicator.adaptive(),
                        title: Text('Fetching your addresses'),
                        enabled: false,
                      ),
                    );
                },
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.truckFast,
                    color: Colors.black,
                  ),
                  title: Text('Within 24 hours'),
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            'Pay with',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          PaywithView(
            onSelect: (method) {
              setState(() {
                selectedMethod = method;
              });
            },
          ),
          SizedBox(height: 18),
          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 0,
                  color: Color(0xFFF6F6F6),
                  style: BorderStyle.none,
                ),
              ),
              fillColor: Color(0xFFF6F6F6),
              filled: true,
              hintText: 'Add a note',
              labelText: 'Notes',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            onChanged: (value) => notes = value,
          ),
          SizedBox(height: 18),
          Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub-total',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      intl.NumberFormat.simpleCurrency(name: 'EGP')
                          .format(widget.cart.subtotal)
                          .split('.00')
                          .first,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                widget.cart.coupon == null
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Disscount',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '- ${intl.NumberFormat.simpleCurrency(name: 'EGP').format(widget.cart.coupon!.value).split('.00').first}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      intl.NumberFormat.simpleCurrency(name: 'EGP')
                          .format(widget.cart.total)
                          .split('.00')
                          .first,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                BlocConsumer<CheckoutBloc, CheckoutState>(
                  listener: (context, state) {
                    if (state is CheckoutSuccess) {
                      context.read<CartBloc>().add(ClearCart());
                      Navigator.of(context).popUntil(
                          (route) => route.settings.name == '/primary');
                      final GlobalKey key = GlobalKey();
                      CoolAlert.show(
                        key: key,
                        context: context,
                        type: CoolAlertType.success,
                        title: 'Order Placed',
                        text: 'Your order is on the way',
                        animType: CoolAlertAnimType.slideInUp,
                        backgroundColor: Colors.transparent,
                        confirmBtnText: 'View My Orders',
                        onConfirmBtnTap: () {
                          print(key.currentContext);
                          Navigator.of(key.currentContext!).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider<OrdersBloc>(
                                      create: (context) =>
                                          OrdersBloc()..add(GetOrders()),
                                      child: OrdersScreen())));
                        },
                        closeOnConfirmBtnTap: false,
                      );
                    } else if (state is CheckoutFailed) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.msg)));
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: state is CheckoutLoading
                              ? null
                              : () {
                                  if (selectedAddress != null) {
                                    context
                                        .read<CheckoutBloc>()
                                        .add(CheckoutOrder(
                                            order: Order(
                                          paymentMethod: selectedMethod,
                                          cart: widget.cart,
                                          address: selectedAddress!,
                                          notes: notes,
                                        )));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please select an address')));
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: state is CheckoutLoading
                              ? CircularProgressIndicator.adaptive(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text(
                                  'Place Order',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
