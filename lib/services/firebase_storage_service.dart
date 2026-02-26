import 'package:firebase_storage/firebase_storage.dart';

/// Servicio para gestionar la carga de imágenes desde Firebase Storage
/// 
/// Este servicio proporciona métodos para obtener URLs de descarga
/// de imágenes almacenadas en Firebase Storage de forma dinámica.
class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Ruta real de las imágenes del carrusel en Firebase Storage
  static const String _carouselPath = 'public/home/carousel';

  /// Extensiones de imagen soportadas
  static const List<String> _imageExtensions = [
    '.png',
    '.jpg',
    '.jpeg',
    '.webp',
    '.gif',
  ];

  /// Obtiene dinámicamente TODAS las URLs de imágenes del carrusel
  /// desde Firebase Storage sin hardcodear nombres de archivos.
  /// 
  /// Carga todas las imágenes de la carpeta public/home/carousel/
  /// y las ordena alfabéticamente por nombre.
  /// 
  /// Returns: Lista de URLs de descarga de las imágenes
  /// Throws: Exception si ocurre un error al cargar las imágenes
  Future<List<String>> getHeroCarouselImages() async {
    try {
      // Obtener referencia a la carpeta en Firebase Storage
      final storageRef = _storage.ref().child(_carouselPath);
      
      // Listar TODOS los archivos en la carpeta
      final ListResult result = await storageRef.listAll();
      
      if (result.items.isEmpty) {
        throw Exception('No se encontraron archivos en $_carouselPath');
      }

      // Filtrar solo archivos de imagen
      final imageItems = result.items.where((item) {
        final fileName = item.name.toLowerCase();
        return _imageExtensions.any((ext) => fileName.endsWith(ext));
      }).toList();

      if (imageItems.isEmpty) {
        throw Exception('No se encontraron imágenes en $_carouselPath');
      }

      // Ordenar alfabéticamente por nombre para mantener orden consistente
      imageItems.sort((a, b) => a.name.compareTo(b.name));

      // Obtener URLs de descarga de todas las imágenes
      final List<String> imageUrls = [];
      for (final item in imageItems) {
        try {
          final String downloadUrl = await item.getDownloadURL();
          imageUrls.add(downloadUrl);
          print('✓ Imagen cargada: ${item.name}');
          print('  URL: $downloadUrl');
        } catch (e) {
          print('✗ Error cargando ${item.name}: $e');
          // Continuar con las demás imágenes
        }
      }

      if (imageUrls.isEmpty) {
        throw Exception('No se pudieron obtener URLs de las imágenes');
      }

      print('✓ Total de imágenes cargadas: ${imageUrls.length}');
      return imageUrls;

    } on FirebaseException catch (e) {
      throw Exception('Error de Firebase Storage: ${e.message}');
    } catch (e) {
      throw Exception('Error al obtener imágenes del carrusel: $e');
    }
  }

  /// Obtiene las URLs de descarga de todas las imágenes en una carpeta
  /// 
  /// Método genérico para cargar todas las imágenes de una carpeta específica.
  /// Útil para futuras implementaciones (galería, productos, etc.)
  /// 
  /// [folderPath]: Ruta de la carpeta en Firebase Storage
  /// Returns: Lista de URLs de descarga de las imágenes
  /// Throws: Exception si ocurre un error
  Future<List<String>> getImagesFromFolder(String folderPath) async {
    try {
      final ref = _storage.ref().child(folderPath);
      final ListResult result = await ref.listAll();

      if (result.items.isEmpty) {
        throw Exception('No se encontraron archivos en $folderPath');
      }

      // Filtrar solo archivos de imagen
      final imageItems = result.items.where((item) {
        final fileName = item.name.toLowerCase();
        return _imageExtensions.any((ext) => fileName.endsWith(ext));
      }).toList();

      if (imageItems.isEmpty) {
        throw Exception('No se encontraron imágenes en $folderPath');
      }

      // Ordenar por nombre para mantener orden consistente
      imageItems.sort((a, b) => a.name.compareTo(b.name));

      final List<String> imageUrls = [];
      for (final item in imageItems) {
        try {
          final String downloadUrl = await item.getDownloadURL();
          imageUrls.add(downloadUrl);
        } catch (e) {
          print('Error obteniendo URL de ${item.name}: $e');
        }
      }

      if (imageUrls.isEmpty) {
        throw Exception('No se pudieron obtener URLs de las imágenes');
      }

      return imageUrls;
    } on FirebaseException catch (e) {
      throw Exception('Error de Firebase Storage: ${e.message}');
    } catch (e) {
      throw Exception('Error al listar imágenes de $folderPath: $e');
    }
  }
}
