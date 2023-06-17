import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:sizer/sizer.dart';

class SplashLoadingWidget extends StatelessWidget {
  const SplashLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              Images.LOGO,
              width: 130.sp,
              height: 130.sp,
            ),
          ),
        ),
        const SizedBox(height: 50),
        SpinKitCircle(
          color: AppColors.PRIMARY_COLOR,
          size: 60,
        ),
      ],
    );
  }
}
