import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  // URLs de redes sociales (configurables)
  static const String facebookUrl = 'https://www.facebook.com/share/17vdcLE9dL/';
  static const String instagramUrl = 'https://www.instagram.com/zoevp_crochet?igsh=emR6N2dydmh4bDhx';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF5EDE4),
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 60 : 24,
        vertical: isWeb ? 30 : 25,
      ),
      child: Column(
        children: [
          // Sección de redes sociales
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(
                Icons.facebook_outlined,
                facebookUrl,
              ),
              SizedBox(width: isWeb ? 32 : 24),
              _buildSocialIcon(
                Icons.camera_alt_outlined,
                instagramUrl,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Copyright
          Text(
            '© 2026 Zoe\'s Crochet · Hecho a mano en Colombia',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isWeb ? 14 : 12,
              fontWeight: FontWeight.w300,
              color: const Color(0xFFA89080),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _openUrl(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8DED0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 24,
          color: const Color(0xFF8B7355),
        ),
      ),
    );
  }

  // Método privado para abrir enlaces en nueva pestaña
  Future<void> _openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Si falla, intenta con modo platformDefault
      await launchUrl(url);
    }
  }
}
