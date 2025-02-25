import 'package:flutter/material.dart';

class HeaderInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const HeaderInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
