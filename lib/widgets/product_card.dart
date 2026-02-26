import 'package:flutter/material.dart';
import '../models/bolso.dart';

class ProductCard extends StatelessWidget {
  final Bolso bolso;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.bolso,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE8DED0),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: isWeb ? 80 : 60,
                        color: const Color(0xFFB8A898),
                      ),
                    ),
                    // Indicador de tap
                    if (onTap != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.visibility_outlined,
                            size: 16,
                            color: Color(0xFF8B7355),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Contenido
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(isWeb ? 16 : 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Título
                    Text(
                      bolso.titulo,
                      style: TextStyle(
                        fontSize: isWeb ? 18 : 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8B7355),
                        letterSpacing: 0.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Precio y acción
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${bolso.precio.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: isWeb ? 20 : 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF8B7355),
                            letterSpacing: 0.5,
                          ),
                        ),
                        if (onTap != null)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5EDE4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              size: isWeb ? 20 : 18,
                              color: const Color(0xFF8B7355),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
