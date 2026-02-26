class Bolso {
  final String id;
  final String titulo;
  final String descripcion;
  final double precio;
  final String imageUrl;

  Bolso({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.precio,
    required this.imageUrl,
  });

  // Constructor desde Map (para Firestore)
  factory Bolso.fromMap(Map<String, dynamic> map, String documentId) {
    return Bolso(
      id: documentId,
      titulo: map['titulo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      precio: (map['precio'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  // Convertir a Map (para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'precio': precio,
      'imageUrl': imageUrl,
    };
  }

  // Método copyWith para crear copias con modificaciones
  Bolso copyWith({
    String? id,
    String? titulo,
    String? descripcion,
    double? precio,
    String? imageUrl,
  }) {
    return Bolso(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'Bolso(id: $id, titulo: $titulo, descripcion: $descripcion, precio: $precio, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bolso &&
        other.id == id &&
        other.titulo == titulo &&
        other.descripcion == descripcion &&
        other.precio == precio &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titulo.hashCode ^
        descripcion.hashCode ^
        precio.hashCode ^
        imageUrl.hashCode;
  }
}
