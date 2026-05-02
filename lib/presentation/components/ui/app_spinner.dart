// presentation/components/ui/app_spinner.dart
// SOLID-SRP: única responsabilidad — mostrar indicador de carga.

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AppSpinner extends StatelessWidget {
  final double size;

  const AppSpinner({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          color: AppTheme.primary,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
