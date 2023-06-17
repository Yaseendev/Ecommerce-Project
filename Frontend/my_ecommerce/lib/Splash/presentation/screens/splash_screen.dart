import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Account/presentation/screens/login_screen.dart';
import 'package:my_ecommerce/Primary/presentation/screens/primary_screen.dart';
import 'package:my_ecommerce/Splash/blocs/bloc/initroute_bloc.dart';
import '../widgets/splash_loading_widget.dart';
import '../widgets/splash_no_internet_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InitrouteBloc, InitrouteState>(
          listener: (context, state) {
            if (state is InitrouteNoToken) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  settings: RouteSettings(name: '/login'),
                  builder: (ctx) {
                    return LoginScreen();
                  }));
            }
           else if (state is InitrouteValidToken) {
              context.read<AccountBloc>().add(LoadUserProfileEvent(
                user: state.user,
              ));
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  settings: RouteSettings(name: '/primary'),
                  builder: (ctx) {
                    return PrimaryScreen();
                  }));
            } else if(state is InitrouteInValidToken) {
              //TODO: Logout
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  settings: RouteSettings(name: '/login'),
                  builder: (ctx) {
                    return LoginScreen();
                  }));
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountLoggedIn) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  settings: RouteSettings(name: '/primary'),
                  builder: (ctx) {
                    return const PrimaryScreen();
                  }));
            }
          },
        ),
      ],
      child: Scaffold(body: BlocBuilder<InitrouteBloc, InitrouteState>(
        builder: (context, state) {
          if (state is InitrouteNoInternet)
            return const SplashNoInternetWidget();
          return const SplashLoadingWidget();
        },
      )),
    );
  }
}
