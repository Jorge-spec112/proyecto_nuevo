// main.dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Montaña Quadratip',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: PixelArtMountain(scale: 18), // cambia scale para agrandar/achicar
          ),
        ),
      ),
    );
  }
}

/// Widget que dibuja la "montaña" como una cuadrícula de pixels (cuadraditos).
class PixelArtMountain extends StatelessWidget {
  final double scale; // tamaño de cada cuadrito (px)

  const PixelArtMountain({super.key, this.scale = 12});

  // Mapa 2D donde cada número representa un color (índice)
  // 0 = transparente / cielo, 1 = azul cielo, 2 = sol amarillo,
  // 3 = montaña (marrón/gris), 4 = nieve (blanco), 5 = hierba verde
  static const List<List<int>> _grid = [
    [0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0],
    [0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0],
    [0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0],
    [0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0],
    [0,0,1,1,1,1,1,3,3,1,1,1,1,1,0,0],
    [0,1,1,1,1,1,3,3,3,3,1,1,1,1,1,0],
    [0,1,1,1,1,3,3,3,3,3,3,1,1,1,1,0],
    [1,1,1,1,3,3,3,3,3,3,3,3,1,1,1,1],
    [1,1,1,3,3,3,3,4,4,3,3,3,3,1,1,1],
    [1,1,3,3,3,3,4,4,4,4,3,3,3,3,1,1],
    [1,3,3,3,3,4,4,4,4,4,4,3,3,3,3,1],
    [1,3,3,3,4,4,4,4,4,4,4,4,3,3,3,1],
    [0,1,3,3,4,4,4,4,4,4,4,4,3,3,1,0],
    [0,0,1,3,3,4,4,4,4,4,4,3,3,1,0,0],
    [0,0,0,1,1,3,3,3,3,3,3,1,1,0,0,0],
    [0,0,0,0,0,1,1,5,5,1,1,0,0,0,0,0],
  ];

  // Mapa de colores por índice
  static const Map<int, Color> _palette = {
    0: Colors.transparent,
    1: Color(0xFF87CEEB), // cielo azul claro
    2: Color(0xFFFFD54F), // (ej. sol) - no usado en la grilla actual
    3: Color(0xFF6D4C41), // montaña (marrón)
    4: Colors.white,      // nieve
    5: Color(0xFF66BB6A), // hierba
  };

  @override
  Widget build(BuildContext context) {
    final rows = _grid.length;
    final cols = _grid[0].length;

    return Container(
      // Un pequeño marco y fondo para resaltar el pixel art
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Colors.black26, offset: Offset(0,4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // título pequeño encima
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Montaña — Quadratip',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // grid de píxeles
          SizedBox(
            width: cols * scale,
            height: rows * scale,
            child: Column(
              children: List.generate(rows, (r) {
                return Row(
                  children: List.generate(cols, (c) {
                    final color = _palette[_grid[r][c]] ?? Colors.transparent;
                    return Container(
                      width: scale,
                      height: scale,
                      decoration: BoxDecoration(
                        color: color,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.06),
                          width: 0.5,
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
