// presentation/components/layout/page_wrapper.dart
// SOLID-SRP: única responsabilidad — envolver páginas con padding estándar.

import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  const PageWrapper({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return scrollable ? SingleChildScrollView(child: content) : content;
  }
}
