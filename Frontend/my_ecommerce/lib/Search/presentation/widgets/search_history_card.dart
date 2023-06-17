import 'package:flutter/material.dart';

class SearchHistroyCard extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const SearchHistroyCard({super.key,
  required this.title,
  required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        Icons.history_rounded,
        color: Colors.black,
        size: 26,
      ),
      onTap: onPress,
    );
  }
}
