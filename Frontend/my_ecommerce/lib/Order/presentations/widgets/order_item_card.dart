import 'package:flutter/material.dart';
import 'package:my_ecommerce/Cart/data/models/cart_item.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:intl/intl.dart' as intl;

class OrderItemCard extends StatelessWidget {
  final CartItem item;
  const OrderItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(14)),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              image:
                  item.product.images.isNotEmpty ? item.product.thumbnail : '',
              width: 105,
              height: 105,
              imageErrorBuilder: (context, url, error) => Image.asset(
                Images.PLACEHOLDER,
                width: 105,
                height: 105,
                fit: BoxFit.fill,
              ),
              placeholder: Images.PLACEHOLDER,
            ),
          ),
          //const SizedBox(width: 5),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              // isThreeLine: false,
              title: Text(
                item.product.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    'From ${item.product.brand}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.product.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Quantity: ${item.quantity}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              trailing: Text.rich(
                TextSpan(
                  text: intl.NumberFormat.simpleCurrency(name: 'EGP')
                          .format(item.product.salePrice == null
                              ? item.product.price
                              : item.product.salePrice)
                          .split('.00')
                          .first +
                      ' ',
                  style: TextStyle(
                    fontSize: 16,
                    //color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
