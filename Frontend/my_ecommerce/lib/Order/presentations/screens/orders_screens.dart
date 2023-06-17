import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Order/blocs/orders_bloc/orders_bloc.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        centerTitle: true,
        leading: BackButton(
          color: AppColors.PRIMARY_COLOR,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading)
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            if (state is OrdersLoaded)
              return state.orders.isEmpty
                  ? Center(
                      child: Text('No Orders Yet'),
                    )
                  : ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          order: state.orders[index],
                        );
                      },
                    );
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
