import 'package:flutter/material.dart';
import 'package:custom_text/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Primary/presentation/screens/primary_screen.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:sizer/sizer.dart';
import '../widgets/signup_form.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                state.msg ?? '',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        } else if (state is AccountNoInternet) {
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
        } else if (state is AccountLoggedIn) {
          // context.read<AddressBloc>().add(GetAllAddresses());
          // context.read<WishlistBloc>().add(GetWishList());
          // context.read<CartBloc>().add(GetCart());
          Navigator.of(context).pushReplacement(MaterialPageRoute(
             settings: RouteSettings(name: '/primary'),
              builder: (_) =>
                      PrimaryScreen(),
                  ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 45.sp,
                          foregroundImage: AssetImage(Images.LOGO),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SingupForm(),
                              SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          settings:
                                              RouteSettings(name: '/primary'),
                                          builder: (_) => PrimaryScreen()));
                                },
                                child: Text('Continue as a visitor'),
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                              ),
                              SizedBox(height: 20),
                              CustomText(
                                'Already have an account?  [Sign In]()',
                                definitions: [
                                  SelectiveDefinition(
                                    matcher: const LinkMatcher(),
                                    shownText: (groups) => groups[0]!,
                                  ),
                                ],
                                matchStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                onTap: (_) => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (_) => LoginScreen())),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
