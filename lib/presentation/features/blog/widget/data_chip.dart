import 'package:flutter/material.dart';

class DataChip extends StatelessWidget {
  const DataChip({
    super.key,
    required this.icon,
    required this.data,
  });

  final IconData icon;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          data,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
