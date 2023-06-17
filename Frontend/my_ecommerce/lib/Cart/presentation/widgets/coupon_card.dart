import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/coupon.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  const CouponCard(this.coupon, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('  Applied Coupon'),
          SizedBox(height: 4),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                coupon.name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('- ${coupon.value} EGP'),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        content: Text(
                            'Are you sure you want to remove the coupon \"${coupon.name}\"'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<CouponBloc>()
                                  .add(RemoveCoupon());
                              Navigator.of(ctx).pop();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.close_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
