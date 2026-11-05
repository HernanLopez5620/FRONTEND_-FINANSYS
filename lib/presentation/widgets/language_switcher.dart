// presentation/widgets/language_switcher.dart
// Selector de idioma. Dos formas:
//  - compacto: botón con globo y menú (para la pantalla de login)
//  - completo: fichas ChoiceChip (para el perfil)
// Cambia el idioma de toda la app al instante, sin recargar.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/idioma_provider.dart';

class LanguageSwitcher extends StatelessWidget {
  final bool compact;
  const LanguageSwitcher({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final idioma = context.watch<IdiomaProvider>();
    final actual = idioma.locale.languageCode;
    final cs = Theme.of(context).colorScheme;

    if (compact) {
      return PopupMenuButton<String>(
        tooltip: IdiomaProvider.nombres[actual],
        onSelected: (code) => idioma.setLocale(Locale(code)),
        itemBuilder: (_) => [
          for (final l in IdiomaProvider.soportados)
            PopupMenuItem<String>(
              value: l.languageCode,
              child: Row(
                children: [
                  Icon(
                    l.languageCode == actual
                        ? Icons.check_rounded
                        : Icons.language_rounded,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(IdiomaProvider.nombres[l.languageCode]!),
                ],
              ),
            ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language_rounded, size: 20, color: cs.onSurface),
              const SizedBox(width: 6),
              Text(
                actual.toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final l in IdiomaProvider.soportados)
          ChoiceChip(
            label: Text(IdiomaProvider.nombres[l.languageCode]!),
            selected: l.languageCode == actual,
            onSelected: (_) => idioma.setLocale(l),
          ),
      ],
    );
  }
}
