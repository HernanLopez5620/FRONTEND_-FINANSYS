// presentation/pages/terminos_page.dart
import 'package:flutter/material.dart';

class TerminosPage extends StatelessWidget {
  const TerminosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Términos y Condiciones de Uso',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface)),
            const SizedBox(height: 4),
            Text('Última actualización: octubre 2026',
                style: TextStyle(
                    fontSize: 12, color: cs.onSurface.withOpacity(0.5))),
            const SizedBox(height: 24),
            _Seccion(
              numero: '1',
              titulo: 'Aceptación de los Términos',
              contenido:
                  'Al crear una cuenta en FinanSys, usted acepta quedar vinculado por estos Términos y Condiciones. Si no está de acuerdo con alguna parte de estos términos, no podrá acceder al servicio.',
            ),
            _Seccion(
              numero: '2',
              titulo: 'Descripción del Servicio',
              contenido:
                  'FinanSys es una aplicación de gestión de finanzas personales que permite registrar ingresos, gastos, presupuestos y realizar conversiones de divisas. El servicio se proporciona "tal como está" y puede ser modificado o discontinuado en cualquier momento.',
            ),
            _Seccion(
              numero: '3',
              titulo: 'Registro y Cuenta de Usuario',
              contenido:
                  'Para usar FinanSys debe crear una cuenta proporcionando información verídica y actualizada. Usted es responsable de mantener la confidencialidad de su contraseña y de todas las actividades que ocurran bajo su cuenta. Debe notificarnos inmediatamente sobre cualquier uso no autorizado.',
            ),
            _Seccion(
              numero: '4',
              titulo: 'Privacidad y Tratamiento de Datos',
              contenido:
                  'Recopilamos y procesamos sus datos personales de acuerdo con nuestra Política de Privacidad. Sus datos financieros son privados y no serán compartidos con terceros sin su consentimiento explícito, salvo requerimiento legal. Las contraseñas se almacenan cifradas y nunca en texto plano.',
            ),
            _Seccion(
              numero: '5',
              titulo: 'Uso Aceptable',
              contenido:
                  'Usted se compromete a usar FinanSys únicamente para fines legítimos y personales. Está prohibido: intentar acceder a cuentas de otros usuarios, realizar ingeniería inversa del sistema, usar el servicio para actividades ilegales, o intentar comprometer la seguridad de la plataforma.',
            ),
            _Seccion(
              numero: '6',
              titulo: 'Limitación de Responsabilidad',
              contenido:
                  'FinanSys no se responsabiliza por decisiones financieras tomadas con base en la información mostrada en la aplicación. La información de tasas de cambio es referencial y puede variar. No garantizamos la disponibilidad continua del servicio.',
            ),
            _Seccion(
              numero: '7',
              titulo: 'Propiedad Intelectual',
              contenido:
                  'Todo el contenido, diseño, código y funcionalidades de FinanSys son propiedad de sus desarrolladores. No se permite reproducir, distribuir o crear trabajos derivados sin autorización expresa por escrito.',
            ),
            _Seccion(
              numero: '8',
              titulo: 'Modificaciones',
              contenido:
                  'Nos reservamos el derecho de modificar estos términos en cualquier momento. Los cambios entrarán en vigor al ser publicados en la aplicación. El uso continuado del servicio después de los cambios constituye aceptación de los nuevos términos.',
            ),
            _Seccion(
              numero: '9',
              titulo: 'Cancelación de Cuenta',
              contenido:
                  'Puede cancelar su cuenta en cualquier momento. Al hacerlo, todos sus datos serán eliminados permanentemente de nuestros servidores. Nos reservamos el derecho de suspender cuentas que violen estos términos.',
            ),
            _Seccion(
              numero: '10',
              titulo: 'Contacto',
              contenido:
                  'Para preguntas sobre estos Términos y Condiciones puede contactarnos a través de la aplicación. Haremos nuestro mejor esfuerzo para responder en un plazo razonable.',
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.primary.withOpacity(0.2)),
              ),
              child: Text(
                'Al crear una cuenta en FinanSys, confirmas que has leído, entendido y aceptado estos Términos y Condiciones en su totalidad.',
                style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.8),
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Entendido, acepto los términos'),
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
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
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
