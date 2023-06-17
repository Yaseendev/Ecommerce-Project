import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Primary/presentation/screens/primary_screen.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import '../widgets/account_screen_items.dart';
import '../widgets/user_inf0_items.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountLoggedout) {
          //   context
          //..read<AddressesBloc>().add(Reset())
          // ..read<CartBloc>().add(ResetCart());
          //..read<WishlistBloc>().add(ResetWishlist());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  settings: RouteSettings(name: '/primary'),
                  builder: (ctx) {
                    return PrimaryScreen();
                  }),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 25,
                left: 8,
                right: 8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      Images.DEFAULT_PROFILE,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 10),
                  state is AccountLoggedIn
                      ? Text(
                          state.user.name.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : TextButton.icon(
                          icon: const Icon(Icons.login),
                          label: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          style: TextButton.styleFrom(
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          },
                        ),
                  state is AccountLoggedIn
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                             UserInfoItems(),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  const AccountScreenItems(),
                  const SizedBox(height: 20),
                  state is AccountLoggedIn
                      ? Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.PRIMARY_COLOR,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(pi),
                                child: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: const Text('Log Out'),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    title: Text('Log Out'),
                                    content: Text(
                                        'Are you sure you want to log out?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text('Log out'),
                                      ),
                                    ],
                                  );
                                },
                              ).then((value) {
                                if (value != null && value) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  );
                                  // context.read<AccountBloc>().add(Logout());
                                }
                              });
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
