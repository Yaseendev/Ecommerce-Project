import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ShippingInfoSection extends StatelessWidget {
  const ShippingInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping Information:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Shipping: ',
                  children: [
                    TextSpan(
                      text: 'Shipping from Cairo, Egypt',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: 'Delivery: ',
                  children: [
                    TextSpan(
                      text: 'Free international Delivery',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: 'Arrive: ',
                  children: [
                    TextSpan(
                      text:
                          'Estimated to arrive on ${intl.DateFormat.yMEd().format(DateTime.now().add(Duration(days: 2)))}',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
