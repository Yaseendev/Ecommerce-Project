import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'filter_sheet_chip.dart';

class BrandsFilterSection extends StatefulWidget {
  final List<String> allBrands;
  final Set<String> selectedBrands;
  final Function(String brand) onAdd;
  final Function(String brand) onRemove;
  const BrandsFilterSection({
    super.key,
    required this.allBrands,
    required this.selectedBrands,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<BrandsFilterSection> createState() => _BrandsFilterSectionState();
}

class _BrandsFilterSectionState extends State<BrandsFilterSection> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Brands',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ExtendedWrap(
          maxLines: isExpand ? double.maxFinite.toInt() : 2,
          overflowWidget: TextButton.icon(
            onPressed: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            icon: Icon(isExpand
                ? Icons.arrow_drop_up_rounded
                : Icons.arrow_drop_down_rounded),
            label: Text('Show ${isExpand ? 'less' : 'more'}'),
          ),
          children: widget.allBrands
              .map(
                (brand) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterSheetChip(
                    label: brand,
                    selected: widget.selectedBrands.contains(brand),
                    onSelect: (value) {
                      if (value)
                        widget.onAdd(brand);
                      else
                        widget.onRemove(brand);
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
