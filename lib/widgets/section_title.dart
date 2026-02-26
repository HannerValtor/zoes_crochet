import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool isLarge;

  const SectionTitle({
    super.key,
    required this.title,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return Text(
      title,
      style: TextStyle(
        fontSize: isLarge
            ? (isWeb ? 48 : 32)
            : (isWeb ? 28 : 22),
        fontWeight: FontWeight.w300,
        letterSpacing: 2,
        color: const Color(0xFF8B7355),
      ),
    );
  }
}
