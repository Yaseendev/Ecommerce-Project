import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Order/blocs/order_bloc/order_bloc.dart';
import 'package:my_ecommerce/Order/blocs/orders_bloc/orders_bloc.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:intl/intl.dart' as intl;
import '../screens/order_screen.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<OrdersBloc>(
                    create: (ctx) => context.read<OrdersBloc>(),
                  ),
                  BlocProvider<OrderBloc>(
                    create: (context) => OrderBloc(),
                  ),
                ],
                child: OrderScreen(
                  order: order,
                ),
              ))),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 12,
              ),
              child: Text.rich(TextSpan(
                text: 'Order ID: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: order.id,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              )),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Items: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${order.cart.cartContent.length} ${order.cart.cartContent.length > 1 ? 'Items' : 'Item'}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text.rich(
                    TextSpan(
                      text: 'Status: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: order.status?.label,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: order.status?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(intl.DateFormat('yMMMMEEEEd')
                      .add_jm()
                      .format(order.orderedAt!)),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
