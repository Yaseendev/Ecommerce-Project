import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_ecommerce/Utils/constants.dart';

Future<dynamic> showLoginDialog(BuildContext context, String reason) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        title: Column(
          children: [
            SvgPicture.asset(
              Images.NO_LOGIN,
              height: 180,
            ),
            Text('You are not Logged In'),
          ],
        ),
        content: Text(
          'Login to $reason',
          textAlign: TextAlign.center,
        ),
        actions: [
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            label: Text('Cancel'),
            icon: Icon(Icons.cancel_outlined),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: Text('Login'),
            icon: Icon(Icons.login_rounded),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      );
    },
  );
}
