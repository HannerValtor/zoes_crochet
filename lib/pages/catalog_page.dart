import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/section_title.dart';
import '../widgets/product_card.dart';
import '../widgets/app_footer.dart';
import '../models/bolso.dart';
import '../services/mock_bolsos_service.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late Future<List<Bolso>> _bolsosFuture;

  @override
  void initState() {
    super.initState();
    _bolsosFuture = MockBolsosService.getBolsos();
  }

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
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: EdgeInsets.all(isWeb ? 60 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(
                      title: 'Catálogo',
                      isLarge: true,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Descubre nuestra colección de bolsos artesanales',
                      style: TextStyle(
                        fontSize: isWeb ? 18 : 16,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFFA89080),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FutureBuilder<List<Bolso>>(
                      future: _bolsosFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(60.0),
                              child: CircularProgressIndicator(
                                color: Color(0xFF8B7355),
                              ),
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Text(
                                'Error al cargar los bolsos',
                                style: TextStyle(
                                  fontSize: isWeb ? 18 : 16,
                                  color: const Color(0xFFA89080),
                                ),
                              ),
                            ),
                          );
                        }

                        final bolsos = snapshot.data ?? [];

                        if (bolsos.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Text(
                                'No hay bolsos disponibles',
                                style: TextStyle(
                                  fontSize: isWeb ? 18 : 16,
                                  color: const Color(0xFFA89080),
                                ),
                              ),
                            ),
                          );
                        }

                        return _buildBolsosGrid(bolsos, isWeb);
                      },
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

  Widget _buildBolsosGrid(List<Bolso> bolsos, bool isWeb) {
    final crossAxisCount = isWeb ? 3 : 2;
    final childAspectRatio = isWeb ? 0.75 : 0.7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: isWeb ? 24 : 16,
        mainAxisSpacing: isWeb ? 24 : 16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: bolsos.length,
      itemBuilder: (context, index) {
        return ProductCard(
          bolso: bolsos[index],
          onTap: () => _handleProductTap(bolsos[index]),
        );
      },
    );
  }

  void _handleProductTap(Bolso bolso) {
    // TODO: Navegar a pantalla de detalle del producto
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Seleccionaste: ${bolso.titulo}',
          style: const TextStyle(letterSpacing: 1),
        ),
        backgroundColor: const Color(0xFF8B7355),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
