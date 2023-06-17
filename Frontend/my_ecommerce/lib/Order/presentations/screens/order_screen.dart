import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Order/blocs/order_bloc/order_bloc.dart';
import 'package:my_ecommerce/Order/blocs/orders_bloc/orders_bloc.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/enums.dart';
import '../widgets/bottom_order_details_card.dart';
import '../widgets/order_info_section.dart';
import '../widgets/order_item_card.dart';
import '../widgets/order_status_stepper.dart';

class OrderScreen extends StatefulWidget {
  final Order order;
  const OrderScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late int currentStep;
  late OrderStatus status;

  @override
  void initState() {
    status = widget.order.status ?? OrderStatus.UNKNOWN;
    switch (status) {
      case OrderStatus.PLACED:
        currentStep = 1;
        break;
      case OrderStatus.REVIEW:
        currentStep = 1;
        break;
      case OrderStatus.ACCEPTED:
        currentStep = 2;
        break;
      case OrderStatus.REJECTED:
        currentStep = 1;
        break;
      case OrderStatus.CANCELED:
        currentStep = 1;
        break;
      case OrderStatus.PREPARING:
        currentStep = 2;
        break;
      case OrderStatus.DELIVERING:
        currentStep = 3;
        break;
      case OrderStatus.DELIVERED:
        currentStep = 5;
        break;
      case OrderStatus.UNKNOWN:
        currentStep = 0;
        break;
      default:
        currentStep = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                state.msg,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        } else if (state is OrderNoInternet) {
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
        } else if (state is OrderCanceled) {
          setState(() {
            status = OrderStatus.CANCELED;
          });
          context.read<OrdersBloc>().add(GetOrders());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Order Details',
            style: TextStyle(
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          centerTitle: true,
          leading: const BackButton(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderStatusStepper(
                  currentStep: currentStep,
                  status: status,
                ),
                const Divider(),
                OrderInfoSection(
                  order: widget.order,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: widget.order.cart.cartContent.length,
                  itemBuilder: (context, index) =>
                      OrderItemCard(item: widget.order.cart.cartContent[index]),
                )),
                BottomOrderDetailsCard(
                  order: widget.order,
                  currentState: currentStep,
                  status: status,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
