import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class FilterHeader extends StatelessWidget {
  final VoidCallback onDone;
  const FilterHeader({
    super.key,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: const Icon(Icons.close),
            label: Text(
              'Clear',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const Text(
            'Filter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton.icon(
            onPressed: onDone,
            label: const Text(
              'Apply',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            icon: Icon(Icons.check_rounded),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              backgroundColor: AppColors.PRIMARY_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}
