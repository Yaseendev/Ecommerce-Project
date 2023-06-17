import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class SortChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool value) onSelect;
  const SortChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (value) {
          onSelect(value);
        },
        labelStyle: TextStyle(
          color: selected ? AppColors.PRIMARY_COLOR : Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: selected ? AppColors.PRIMARY_COLOR : Colors.black,
          width: selected ? 1.5 : 1.0,
        ),
        padding: EdgeInsets.all(8),
        backgroundColor: Colors.transparent,
        selectedColor: AppColors.PRIMARY_COLOR.withAlpha(55),
      ),
    );
  }
}
