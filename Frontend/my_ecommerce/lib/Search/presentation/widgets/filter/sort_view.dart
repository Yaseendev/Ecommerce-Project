import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/enums.dart';
import 'sort_chip.dart';

class SortView extends StatelessWidget {
  final SortOptions groupValue;
  final Function(SortOptions value) onSelectSort;
  const SortView({
    super.key,
    required this.groupValue,
    required this.onSelectSort,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
       
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: SortOptions.values.map((op) => SortChip(
                label: op.title,
                selected: groupValue == op,
                onSelect: (value) {
                  if (value) {
                    onSelectSort(op);
                  }
                },
              ),).toList(),
          ),
        ),
      ],
    );
  }
}
