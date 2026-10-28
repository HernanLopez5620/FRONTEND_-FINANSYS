// presentation/widgets/inactividad_detector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/inactividad_provider.dart';

class InactividadDetector extends StatelessWidget {
  final Widget child;
  const InactividadDetector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) =>
          context.read<InactividadProvider>().registrarActividad(),
      onPointerMove: (_) =>
          context.read<InactividadProvider>().registrarActividad(),
      onPointerUp: (_) =>
          context.read<InactividadProvider>().registrarActividad(),
      child: child,
    );
  }
}
