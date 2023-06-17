import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Search/blocs/filter_bloc/filter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'Account/blocs/account_bloc/account_bloc.dart';
import 'Address/blocs/addresses_bloc/addresses_bloc.dart';
import 'Cart/blocs/cart_bloc/cart_bloc.dart';
import 'Order/blocs/orders_bloc/orders_bloc.dart';
import 'Primary/blocs/categories_bloc/categories_bloc.dart';
import 'Splash/blocs/bloc/initroute_bloc.dart';
import 'Splash/presentation/screens/splash_screen.dart';
import 'Utils/constants.dart';
import 'Utils/services/service_locator.dart';
import 'Wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();
  await locatorsSetup();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(),
          ),
          BlocProvider<InitrouteBloc>(
            create: (context) => InitrouteBloc()..add(UserCheckEvent()),
          ),
          BlocProvider<FilterBloc>(
            create: (context) => FilterBloc(),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(context),
          ),
          BlocProvider<CategoriesBloc>(
            create: (context) => CategoriesBloc(),
          ),
           BlocProvider<WishlistBloc>(
            create: (context) => WishlistBloc(),
          ),
          BlocProvider<AddressesBloc>(
          create: (context) => AddressesBloc(),
        ),
        //   BlocProvider<OrdersBloc>(
        //   create: (context) => OrdersBloc(),
        // ),
        
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-commerce App',
          theme: ThemeData(
            primarySwatch: AppColors.PRIMARY_SWATCH,
            primaryColor: AppColors.PRIMARY_COLOR,
            scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
          ),
          home: const SplashScreen(),
        ),
      );
    });
  }
}