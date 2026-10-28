// core/theme/app_theme.dart
// SOLID-SRP: única responsabilidad — definir el tema visual global.

import 'package:flutter/material.dart';

/// Colores del encabezado superior (cada tema define los suyos).
class AppHeaderColors extends ThemeExtension<AppHeaderColors> {
  final Color background;
  final Color foreground;
  const AppHeaderColors({required this.background, required this.foreground});

  @override
  AppHeaderColors copyWith({Color? background, Color? foreground}) =>
      AppHeaderColors(
        background: background ?? this.background,
        foreground: foreground ?? this.foreground,
      );

  @override
  AppHeaderColors lerp(ThemeExtension<AppHeaderColors>? other, double t) {
    if (other is! AppHeaderColors) return this;
    return AppHeaderColors(
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
    );
  }
}

class AppTheme {
  // ── Colores base (restaurados los que faltaban)
  static const Color primary = Color(0xFF1F5C2E);
  static const Color primaryLight = Color(0xFF2E7D32);
  static const Color primaryDark = Color(0xFF143D1E); // <-- Restaurado
  static const Color surface = Color(0xFFE8F5E9);
  static const Color bgPage = Color(0xFFF2F7F2);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgInput = Color(0xFFF5F5F5); // <-- Restaurado
  static const Color border = Color(0xFFE0E0E0);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF666666);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color success = Color(0xFF2E7D32); // <-- Restaurado
  static const Color warning = Color(0xFFED6C02); // <-- Restaurado
  static const Color danger = Color(0xFFD32F2F);
  static const Color dangerSurface = Color(0xFFFFEBEE);

  // <-- Restaurados los colores de categorías para los gráficos
  static const List<Color> categoryColors = [
    Color(0xFF2196F3), // Azul
    Color(0xFF4CAF50), // Verde
    Color(0xFFFFC107), // Amarillo
    Color(0xFFF44336), // Rojo
    Color(0xFF9C27B0), // Morado
    Color(0xFFFF9800), // Naranja
    Color(0xFF009688), // Verde azulado
    Color(0xFF795548), // Marrón
  ];

  // ── Tema CLARO
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: bgPage,
        cardColor: bgCard,
        extensions: const [
          AppHeaderColors(background: primary, foreground: Colors.white),
        ],
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      );

  // ── Tema OSCURO

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Colors.white, // Blanco: letras e iconos legibles
          onPrimary: const Color(0xFF143D1E), // Texto sobre fondos blancos
          surface: const Color(0xFF1E1E1E), // Gris oscuro para tarjetas
          onSurface: Colors.white,
          surfaceVariant: const Color(0xFF2A2A2A), // Gris un poco más claro
          onSurfaceVariant:
              const Color(0xFFAAAAAA), // Gris para textos secundarios
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        extensions: const [
          AppHeaderColors(
              background: Color(0xFF143D1E), foreground: Colors.white),
        ],
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:
              Color(0xFF1E1E1E), // Asegura que el panel de abajo se vea
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(
              0xFF121212), // Fondo oscuro para el AppBar en lugar de verde
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF143D1E), // Botones verde oscuro
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: const Color(0xFF2A2A2A),
        ),
      );

  // ── Tema GAMER (antes Opera GX). La clave interna sigue siendo 'operagx'
  //    para no romper el tema ya guardado en la cuenta de cada usuario.
  static ThemeData get operagx => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFF4D6A),
          secondary: const Color(0xFF00E5FF),
          surface: const Color(0xFF1A0A1A),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D0D1A),
        cardColor: const Color(0xFF1A1A2E),
        extensions: const [
          // Encabezado en un tono ciruela suave en lugar del rojo fuerte
          AppHeaderColors(
              background: Color(0xFF4A2340), foreground: Colors.white),
        ],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0D1A),
          foregroundColor: Color(0xFFF2A0B0),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4D6A),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            shadowColor: const Color(0xFFFF4D6A),
            elevation: 8,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF4D6A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3A1A3A)),
          ),
          filled: true,
          fillColor: const Color(0xFF1A1A2E),
          labelStyle: const TextStyle(color: Color(0xFF00E5FF)),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      );

  // ── Helper para obtener el tema por nombre
  static ThemeData fromNombre(String nombre) {
    switch (nombre) {
      case 'oscuro':
        return dark;
      case 'operagx':
      case 'gamer':
        return operagx;
      default:
        return light;
    }
  }
}
