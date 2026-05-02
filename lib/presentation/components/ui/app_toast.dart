// presentation/components/ui/app_toast.dart
// SOLID-SRP: única responsabilidad — mostrar mensajes de notificación.

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

enum ToastType { success, error, warning, info }

class AppToast {
  static void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.info,
  }) {
    final colors = {
      ToastType.success: AppTheme.success,
      ToastType.error: AppTheme.danger,
      ToastType.warning: AppTheme.warning,
      ToastType.info: AppTheme.primary,
    };

    final icons = {
      ToastType.success: Icons.check_circle_outline_rounded,
      ToastType.error: Icons.error_outline_rounded,
      ToastType.warning: Icons.warning_amber_rounded,
      ToastType.info: Icons.info_outline_rounded,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(icons[type], color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ]),
        backgroundColor: colors[type],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
