import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class FilterSheetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool value) onSelect;
  const FilterSheetChip({
    Key? key,
    required this.label,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (value) {
        onSelect(value);
      },
      labelStyle: TextStyle(
        color: selected ? AppColors.PRIMARY_COLOR : null,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      side: BorderSide(
        color: selected ? AppColors.PRIMARY_COLOR : Colors.transparent,
        width: selected ? 1.5 : 1.0,
      ),
      selectedColor: AppColors.PRIMARY_COLOR.withAlpha(55),
      checkmarkColor: AppColors.PRIMARY_COLOR,
      padding: EdgeInsets.all(8),
    );
  }
}
