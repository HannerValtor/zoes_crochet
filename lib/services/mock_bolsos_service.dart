import '../models/bolso.dart';

class MockBolsosService {
  // Simula una llamada asíncrona a una base de datos
  static Future<List<Bolso>> getBolsos() async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _mockBolsos;
  }

  // Obtener un bolso por ID
  static Future<Bolso?> getBolsoById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return _mockBolsos.firstWhere((bolso) => bolso.id == id);
    } catch (e) {
      return null;
    }
  }

  // Lista de bolsos simulados
  static final List<Bolso> _mockBolsos = [
    Bolso(
      id: '1',
      titulo: 'Bolso Clásico Beige',
      descripcion: 'Elegante bolso tejido a mano en tonos beige. Perfecto para el día a día, combina con cualquier outfit. Hecho con hilo de algodón premium.',
      precio: 45.99,
      imageUrl: 'assets/images/bolso1.jpg',
    ),
    Bolso(
      id: '2',
      titulo: 'Bolso Bohemio Multicolor',
      descripcion: 'Vibrante bolso con diseño bohemio en colores cálidos. Ideal para salidas casuales y festivales. Incluye forro interior y cierre magnético.',
      precio: 52.50,
      imageUrl: 'assets/images/bolso2.jpg',
    ),
    Bolso(
      id: '3',
      titulo: 'Bolso Mini Crema',
      descripcion: 'Adorable bolso pequeño en tono crema, perfecto para llevar lo esencial. Correa ajustable y diseño minimalista. Ideal para ocasiones especiales.',
      precio: 38.00,
      imageUrl: 'assets/images/bolso3.jpg',
    ),
    Bolso(
      id: '4',
      titulo: 'Bolso Grande Terracota',
      descripcion: 'Espacioso bolso en tono terracota, ideal para playa o compras. Resistente y duradero, con asas reforzadas. Tejido con técnica de punto alto.',
      precio: 65.00,
      imageUrl: 'assets/images/bolso4.jpg',
    ),
    Bolso(
      id: '5',
      titulo: 'Bolso Elegante Negro',
      descripcion: 'Sofisticado bolso negro con detalles dorados. Perfecto para eventos formales o uso profesional. Incluye compartimentos internos organizadores.',
      precio: 58.75,
      imageUrl: 'assets/images/bolso5.jpg',
    ),
    Bolso(
      id: '6',
      titulo: 'Bolso Veraniego Coral',
      descripcion: 'Fresco bolso en tono coral, ideal para el verano. Ligero y espacioso, con diseño de flores tejidas. Perfecto para días soleados.',
      precio: 48.00,
      imageUrl: 'assets/images/bolso6.jpg',
    ),
  ];

  // Método para obtener bolsos por rango de precio
  static Future<List<Bolso>> getBolsosByPriceRange(
    double minPrice,
    double maxPrice,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return _mockBolsos
        .where((bolso) => bolso.precio >= minPrice && bolso.precio <= maxPrice)
        .toList();
  }

  // Método para buscar bolsos por título
  static Future<List<Bolso>> searchBolsos(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) return _mockBolsos;
    
    final lowerQuery = query.toLowerCase();
    return _mockBolsos
        .where((bolso) =>
            bolso.titulo.toLowerCase().contains(lowerQuery) ||
            bolso.descripcion.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
