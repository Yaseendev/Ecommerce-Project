import 'package:flutter/material.dart';

class PriceRangeView extends StatelessWidget {
  final double? startPrice, endPrice;
  final Function(double? start) onStartPriceChnage;
  final Function(double? end) onEndPriceChnage;

  const PriceRangeView({
    super.key,
    required this.startPrice,
    required this.endPrice,
    required this.onStartPriceChnage,
    required this.onEndPriceChnage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price Range',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            //color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 45,
              width: 125,
              child: TextFormField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                initialValue: startPrice != null ? '$startPrice' : null,
                validator: (val) {
                  if (val != null) {
                    if (val.isNotEmpty) {
                      if (double.tryParse(val) == null) return 'invalid value';
                    } else {
                      if (endPrice != null) return 'Required for range';
                    }
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onChanged: (value) => onStartPriceChnage(double.tryParse(value.trim())),
              ),
            ),
            Text(
              '-',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            SizedBox(
                height: 45,
                width: 125,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  initialValue: endPrice != null ? '$endPrice' : null,
                  validator: (val) {
                    if (val != null) {
                      print('$val');
                      if (val.isNotEmpty) {
                        if (double.tryParse(val) == null)
                          return 'invalid value';
                      } else {
                        if (startPrice != null) return 'Required for range';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (value) => onEndPriceChnage(double.tryParse(value.trim())),
                )),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
