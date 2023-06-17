import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Splash/blocs/bloc/initroute_bloc.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:sizer/sizer.dart';

class SplashNoInternetWidget extends StatelessWidget {
  const SplashNoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            Images.NO_INTERNET,
            width: 130.sp,
            height: 130.sp,
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        const SizedBox(height: 50),
        Text('No Internet Connection'),
        TextButton(
            onPressed: () {
              context.read<InitrouteBloc>().add(UserCheckEvent());
            },
            child: Text('Try Again')),
      ],
    );
  }
}
