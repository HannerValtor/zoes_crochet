import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/app_footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: const AppHeader(),
      drawer: isWeb ? null : const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carrusel de imágenes hero
            const HeroCarousel(),

            // Texto de marca
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Bolsos tejidos a mano con amor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isWeb ? 32 : 24,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.5,
                  color: const Color(0xFF8B7355),
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Cada pieza es única y hecha con dedicación',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isWeb ? 18 : 16,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFA89080),
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 60),
            
            // Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
