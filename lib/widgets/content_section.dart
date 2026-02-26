import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  final String? title;
  final String content;
  final IconData? icon;

  const ContentSection({
    super.key,
    this.title,
    required this.content,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return Container(
      padding: EdgeInsets.all(isWeb ? 32 : 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5EDE4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8DED0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF8B7355),
                size: isWeb ? 32 : 28,
              ),
            ),
            const SizedBox(height: 20),
          ],
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: isWeb ? 24 : 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                color: const Color(0xFF8B7355),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            content,
            style: TextStyle(
              fontSize: isWeb ? 18 : 16,
              fontWeight: FontWeight.w300,
              color: const Color(0xFFA89080),
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
