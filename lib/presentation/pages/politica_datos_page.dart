// presentation/pages/politica_datos_page.dart
import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

class PoliticaDatosPage extends StatelessWidget {
  const PoliticaDatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.legalPrivacyAppBarTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.legalPrivacyTitle,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface)),
            const SizedBox(height: 4),
            Text(context.l10n.legalLastUpdated,
                style: TextStyle(
                    fontSize: 12, color: cs.onSurface.withOpacity(0.5))),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                context.l10n.legalPrivacyIntro,
                style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.8),
                    height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
            _Seccion(
              numero: '1',
              titulo: context.l10n.legalPrivacySection1Title,
              contenido: context.l10n.legalPrivacySection1Body,
            ),
            _Seccion(
              numero: '2',
              titulo: context.l10n.legalPrivacySection2Title,
              contenido: context.l10n.legalPrivacySection2Body,
            ),
            _Seccion(
              numero: '3',
              titulo: context.l10n.legalPrivacySection3Title,
              contenido: context.l10n.legalPrivacySection3Body,
            ),
            _Seccion(
              numero: '4',
              titulo: context.l10n.legalPrivacySection4Title,
              contenido: context.l10n.legalPrivacySection4Body,
            ),
            _Seccion(
              numero: '5',
              titulo: context.l10n.legalPrivacySection5Title,
              contenido: context.l10n.legalPrivacySection5Body,
            ),
            _Seccion(
              numero: '6',
              titulo: context.l10n.legalPrivacySection6Title,
              contenido: context.l10n.legalPrivacySection6Body,
            ),
            _Seccion(
              numero: '7',
              titulo: context.l10n.legalPrivacySection7Title,
              contenido: context.l10n.legalPrivacySection7Body,
            ),
            _Seccion(
              numero: '8',
              titulo: context.l10n.legalPrivacySection8Title,
              contenido: context.l10n.legalPrivacySection8Body,
            ),
            _Seccion(
              numero: '9',
              titulo: context.l10n.legalPrivacySection9Title,
              contenido: context.l10n.legalPrivacySection9Body,
            ),
            _Seccion(
              numero: '10',
              titulo: context.l10n.legalPrivacySection10Title,
              contenido: context.l10n.legalPrivacySection10Body,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.primary.withOpacity(0.2)),
              ),
              child: Column(children: [
                Icon(Icons.verified_user_outlined, color: cs.primary, size: 32),
                const SizedBox(height: 8),
                Text(
                  context.l10n.legalPrivacyFooterNote,
                  style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurface.withOpacity(0.8),
                      fontStyle: FontStyle.italic,
                      height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(context.l10n.legalPrivacyAcceptButton),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _Seccion extends StatelessWidget {
  final String numero;
  final String titulo;
  final String contenido;

  const _Seccion({
    required this.numero,
    required this.titulo,
    required this.contenido,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 28,
              height: 28,
              decoration:
                  BoxDecoration(color: cs.primary, shape: BoxShape.circle),
              child: Center(
                child: Text(numero,
                    style: TextStyle(
                        color: cs.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(titulo,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface)),
            ),
          ]),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Text(contenido,
                style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.7),
                    height: 1.5)),
          ),
        ],
      ),
    );
  }
}
