import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_info_bloc/account_info_bloc.dart';
import 'package:my_ecommerce/Address/presentation/screens/addresses_screen.dart';
import 'package:my_ecommerce/Order/blocs/orders_bloc/orders_bloc.dart';
import 'package:my_ecommerce/Order/presentations/screens/orders_screens.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Wishlist/presentation/screens/wishlist_screen.dart';

import '../screens/edit_account_screen.dart';

class UserInfoItems extends StatelessWidget {
  const UserInfoItems({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoggedIn)
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColors.PRIMARY_COLOR,
                    ),
                    title: Text('Edit Account'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BlocProvider<AccountInfoBloc>(
                              create: (context) => AccountInfoBloc(),
                              child: EditAccountScreen(
                                user: state.user,
                              ),
                            ))),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.person_pin_circle_rounded,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColors.PRIMARY_COLOR,
                    ),
                    title: const Text('Saved Addresses'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AddressesScreen()));
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColors.PRIMARY_COLOR,
                    ),
                    title: Text('Favorites'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => WishlistScreen())),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.inventory_rounded,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColors.PRIMARY_COLOR,
                    ),
                    title: Text('My Orders'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BlocProvider<OrdersBloc>(
                            create: (context) => OrdersBloc()..add(GetOrders()),
                            child: OrdersScreen()))),
                  ),
                ],
              ).toList(),
            ),
          );
        return Container();
      },
    );
  }
}
