import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorView extends StatelessWidget {
  final String? errorTxt;
  const ErrorView({
    super.key,
    this.errorTxt
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/error.jpg',
          fit: BoxFit.fill,
          height: 44.h,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
        ),
        SizedBox(height: 15),
        Text( errorTxt ?? 'Something went wrong',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}