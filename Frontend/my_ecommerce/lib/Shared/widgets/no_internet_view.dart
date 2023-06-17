import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no-wifi.png',
                  fit: BoxFit.fill,
                  height: 25.h,
                  width: MediaQuery.of(context).size.width * .6,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 50),
                Text(
                  'No Internet Connection',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}