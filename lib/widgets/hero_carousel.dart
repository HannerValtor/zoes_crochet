import 'dart:async';
import 'package:flutter/material.dart';
import '../services/firebase_storage_service.dart';

/// Widget de carrusel hero que carga imágenes dinámicamente desde Firebase Storage
/// 
/// Características:
/// - Carga automática desde Firebase Storage
/// - Autoplay cada 4 segundos
/// - Transiciones suaves
/// - Manejo de estados (loading, error, success)
/// - Responsive para web y móvil
class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final FirebaseStorageService _storageService = FirebaseStorageService();
  late PageController _pageController;
  Timer? _autoPlayTimer;
  int _currentPage = 0;
  List<String>? _cachedImageUrls;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _loadAndCacheImages();
  }

  /// Carga y precarga todas las imágenes en caché
  Future<void> _loadAndCacheImages() async {
    try {
      final urls = await _storageService.getHeroCarouselImages();
      setState(() {
        _cachedImageUrls = urls;
      });
      
      // Precargar todas las imágenes en caché
      if (mounted) {
        for (final url in urls) {
          precacheImage(NetworkImage(url), context);
        }
      }
    } catch (e) {
      print('Error precargando imágenes: $e');
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// Inicia el autoplay del carrusel
  void _startAutoPlay(int imageCount) {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && imageCount > 0) {
        final nextPage = _currentPage + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int index, int imageCount) {
    setState(() {
      _currentPage = index % imageCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;
    
    // Altura del hero: 65-70% del viewport en web, 50% en móvil
    final heroHeight = isWeb ? size.height * 0.65 : size.height * 0.5;

    // Si ya tenemos las imágenes en caché, usarlas directamente
    if (_cachedImageUrls != null && _cachedImageUrls!.isNotEmpty) {
      final imageUrls = _cachedImageUrls!;
      
      // Iniciar autoplay cuando las imágenes están listas
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_autoPlayTimer == null || !_autoPlayTimer!.isActive) {
          _startAutoPlay(imageUrls.length);
        }
      });

      return SizedBox(
        height: heroHeight,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => _onPageChanged(index, imageUrls.length),
          itemCount: imageUrls.length * 1000, // Repetición infinita
          itemBuilder: (context, index) {
            final imageIndex = index % imageUrls.length;
            return _buildImageSlide(imageUrls[imageIndex]);
          },
        ),
      );
    }

    // Mientras carga, mostrar indicador
    return FutureBuilder<List<String>>(
      future: _storageService.getHeroCarouselImages(),
      builder: (context, snapshot) {
        // Estado: Cargando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: heroHeight,
            color: const Color(0xFFF5EDE4),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF8B7355),
                strokeWidth: 3,
              ),
            ),
          );
        }

        // Estado: Error
        if (snapshot.hasError) {
          return Container(
            height: heroHeight,
            color: const Color(0xFFE8DED0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off_outlined,
                      size: isWeb ? 80 : 60,
                      color: const Color(0xFFB8A898),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar las imágenes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isWeb ? 18 : 16,
                        color: const Color(0xFF8B7355),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isWeb ? 14 : 12,
                        color: const Color(0xFFA89080),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Estado: Sin datos
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            height: heroHeight,
            color: const Color(0xFFE8DED0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported_outlined,
                    size: isWeb ? 80 : 60,
                    color: const Color(0xFFB8A898),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay imágenes disponibles',
                    style: TextStyle(
                      fontSize: isWeb ? 18 : 16,
                      color: const Color(0xFF8B7355),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Este caso no debería ocurrir porque ya tenemos caché
        return Container(height: heroHeight);
      },
    );
  }

  /// Construye un slide individual del carrusel
  Widget _buildImageSlide(String imageUrl) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFE8DED0),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        cacheWidth: 1920, // Optimización: limitar ancho de caché
        errorBuilder: (context, error, stackTrace) {
          print('Error cargando imagen: $error');
          print('URL: $imageUrl');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.broken_image_outlined,
                  size: 60,
                  color: Color(0xFFB8A898),
                ),
                const SizedBox(height: 12),
                Text(
                  'Error al cargar imagen',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF8B7355),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
