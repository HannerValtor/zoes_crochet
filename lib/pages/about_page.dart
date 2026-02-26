import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/section_title.dart';
import '../widgets/content_section.dart';
import '../widgets/app_footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: EdgeInsets.all(isWeb ? 60 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      title: 'Nuestra Historia',
                      isLarge: true,
                    ),
                    const SizedBox(height: 40),
                    
                    // Origen artesanal
                    Text(
                      'Zoe\'s Crochet nació del amor por el tejido artesanal y el deseo de crear piezas únicas que cuenten una historia. Cada bolso es el resultado de horas de dedicación, paciencia y pasión por el arte del crochet, una técnica tradicional que ha pasado de generación en generación.',
                      style: TextStyle(
                        fontSize: isWeb ? 20 : 18,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF8B7355),
                        height: 1.8,
                      ),
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Imagen decorativa
                    Center(
                      child: Container(
                        width: isWeb ? 500 : double.infinity,
                        height: isWeb ? 350 : 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8DED0),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                size: isWeb ? 100 : 80,
                                color: const Color(0xFFB8A898),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Hecho con amor',
                                style: TextStyle(
                                  fontSize: isWeb ? 20 : 18,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFF8B7355),
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // Misión
                    const ContentSection(
                      title: 'Misión',
                      icon: Icons.track_changes_outlined,
                      content: 'Crear bolsos tejidos a mano de alta calidad que combinen funcionalidad, estilo y sostenibilidad. Nos comprometemos a preservar el arte del crochet mientras ofrecemos piezas únicas que acompañen a nuestros clientes en su día a día.',
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Visión
                    const ContentSection(
                      title: 'Visión',
                      icon: Icons.visibility_outlined,
                      content: 'Ser reconocidos como una marca referente en accesorios artesanales, donde cada pieza refleje calidad, autenticidad y compromiso con el medio ambiente. Aspiramos a inspirar a más personas a valorar el trabajo artesanal y a elegir productos hechos con conciencia.',
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Valores adicionales
                    const SectionTitle(title: 'Nuestros Valores'),
                    const SizedBox(height: 30),
                    
                    _buildValueItem(
                      isWeb,
                      'Artesanía',
                      'Cada pieza es única y hecha a mano con técnicas tradicionales',
                    ),
                    const SizedBox(height: 20),
                    _buildValueItem(
                      isWeb,
                      'Calidad',
                      'Utilizamos materiales premium para garantizar durabilidad',
                    ),
                    const SizedBox(height: 20),
                    _buildValueItem(
                      isWeb,
                      'Sostenibilidad',
                      'Comprometidos con prácticas responsables y conscientes',
                    ),
                    const SizedBox(height: 20),
                    _buildValueItem(
                      isWeb,
                      'Pasión',
                      'Amor por el crochet en cada puntada',
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(bool isWeb, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF8B7355),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isWeb ? 18 : 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8B7355),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: isWeb ? 16 : 14,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFA89080),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
