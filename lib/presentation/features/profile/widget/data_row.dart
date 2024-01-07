import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String data;

  const DataRowWidget(
      {super.key, required this.label, required this.icon, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500 ,fontSize: 13),
          ),
          Expanded(
            child: Text(
              data,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
