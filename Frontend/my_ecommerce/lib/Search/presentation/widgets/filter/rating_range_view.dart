import 'package:flutter/material.dart';

class RatingRangeView extends StatelessWidget {
  const RatingRangeView({
    super.key,
    required this.ratingRange,
    required this.onChange,
  });

  final RangeValues? ratingRange;
  final Function(RangeValues?) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating Range',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            //color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: ratingRange ?? RangeValues(0.0, 5.0),
          divisions: 10,
          labels: RangeLabels(
              ratingRange == null ? '0.0' : ratingRange!.start.toString(),
              ratingRange == null ? '5.0' : ratingRange!.end.toString()),
          max: 5.0,
          min: 0.0,
          onChanged: onChange,
        ),
      ],
    );
  }
}
