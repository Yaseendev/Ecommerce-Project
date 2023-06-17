import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Order/blocs/order_bloc/order_bloc.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:my_ecommerce/Utils/enums.dart';
import 'package:intl/intl.dart' as intl;

class BottomOrderDetailsCard extends StatelessWidget {
  final Order order;
  final int currentState;
  final OrderStatus status;
  const BottomOrderDetailsCard({
    super.key,
    required this.order,
    required this.currentState,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 30,
      type: MaterialType.card,
      borderOnForeground: true,
      shadowColor: Colors.black,
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub-Total',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${intl.NumberFormat.simpleCurrency(name: 'EGP').format(order.cart.subtotal).split('.00').first}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            order.cart.coupon == null
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Voucher ${order.cart.coupon?.name} disscount',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '- ${intl.NumberFormat.simpleCurrency(name: 'EGP').format(order.cart.coupon!.value).split('.00').first}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${intl.NumberFormat.simpleCurrency(name: 'EGP').format(order.cart.total).split('.00').first}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (currentState < 2 &&
                (status != OrderStatus.REJECTED &&
                    status != OrderStatus.CANCELED))
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          //backgroundColor: Colors.red,
                          foregroundColor: Colors.red,
                          side: BorderSide(color: Colors.red)),
                      onPressed: state is OrderLoading
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  title: Text('Cancel Order'),
                                  content: Text(
                                      'Are you sure you want to cancel this order?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('No'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.grey[800],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: Text('Yes'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value != null && value) {
                                  context.read<OrderBloc>().add(CancelOrder(
                                        id: order.id ?? '',
                                      ));
                                }
                              });
                            },
                      label: Text(
                        state is OrderLoading ? 'Canceling...' : 'Cancel Order',
                      ),
                      icon: state is OrderLoading
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Icon(Icons.cancel),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
