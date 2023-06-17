import 'package:flutter/material.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:readmore/readmore.dart';

class OrderInfoSection extends StatelessWidget {
  const OrderInfoSection({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order ID:',
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            Text(
              '${order.id}',
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ordered At:',
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            Text(
              intl.DateFormat.yMMMEd().add_jm().format(order.orderedAt!),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (order.notes.trim().isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes: ',
              ),
              Expanded(
                child: ReadMoreText(
                  order.notes.trim(),
                  moreStyle: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                  lessStyle: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                  trimMode: TrimMode.Line,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
