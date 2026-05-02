// core/theme/app_theme.dart
// SOLID-SRP: única responsabilidad — definir el tema visual global.

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ── Colores principales ──
  static const Color primary = Color(0xFF1A7A3C);
  static const Color primaryDark = Color(0xFF0D5C2E);
  static const Color primaryLight = Color(0xFF2ECC71);
  static const Color surface = Color(0xFFE8F5ED);

  // ── Colores de estado ──
  static const Color danger = Color(0xFFC0392B);
  static const Color dangerSurface = Color(0xFFFDECEB);
  static const Color warning = Color(0xFFE67E22);
  static const Color success = Color(0xFF27AE60);

  // ── Colores de texto ──
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B6B6B);
  static const Color textHint = Color(0xFFAAAAAA);

  // ── Colores de fondo ──
  static const Color bgPage = Color(0xFFF2F6F2);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgInput = Color(0xFFF7FAF7);
  static const Color border = Color(0xFFDDE8DD);

  // ── Colores para categorías ──
  static const List<Color> categoryColors = [
    Color(0xFF1A7A3C),
    Color(0xFF2ECC71),
    Color(0xFF27AE60),
    Color(0xFF3498DB),
    Color(0xFF9B59B6),
    Color(0xFFE67E22),
    Color(0xFFE74C3C),
    Color(0xFF1ABC9C),
    Color(0xFFF39C12),
    Color(0xFF82D8A0),
  ];

  // ── ThemeData global ──
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: bgPage,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primary,
            side: const BorderSide(color: primary, width: 1.5),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: bgInput,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: danger, width: 1),
          ),
          labelStyle: const TextStyle(color: textGrey, fontSize: 14),
          hintStyle: const TextStyle(color: textHint, fontSize: 14),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: bgCard,
          selectedItemColor: primary,
          unselectedItemColor: textHint,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 11),
        ),
      );
}

// ── Estilos de texto reutilizables ──
class AppTextStyles {
  AppTextStyles._();

  static const headline = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppTheme.textDark,
    letterSpacing: -0.5,
  );

  static const subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppTheme.textGrey,
  );

  static const body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppTheme.textDark,
  );

  static const label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppTheme.textGrey,
    letterSpacing: 0.2,
  );

  static const amountLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -1,
  );
}
