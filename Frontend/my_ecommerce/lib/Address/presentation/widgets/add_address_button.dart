import 'package:flutter/material.dart';
import '../screens/location_selection_screen.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => LocationSelectionScreen()));
          },
          child: const Text('Add Address'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
