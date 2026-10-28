// presentation/components/ui/app_spinner.dart
// SOLID-SRP: única responsabilidad — mostrar indicador de carga.

import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  final double size;

  const AppSpinner({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
