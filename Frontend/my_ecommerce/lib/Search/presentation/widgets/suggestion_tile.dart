import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class SuggestionTile extends StatelessWidget {
  final Product suggestion;
  const SuggestionTile(
    this.suggestion, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          image: suggestion.images.first,
          width: 70,
          height: 80,
          imageErrorBuilder: (context, error, stackTrace) => Image.asset(
            Images.PLACEHOLDER,
            fit: BoxFit.fill,
            width: 70,
            height: 80,
          ),
          placeholder: Images.PLACEHOLDER,
        ),
      ),
      title: Text(suggestion.name),
      subtitle: Text('${suggestion.brand}'),
      trailing: Text(intl.NumberFormat.simpleCurrency(name: 'EGP')
          .format(suggestion.price)
          .split('.00')
          .first),
    );
  }
}
