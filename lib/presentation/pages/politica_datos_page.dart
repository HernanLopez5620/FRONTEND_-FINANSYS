// presentation/pages/politica_datos_page.dart
import 'package:flutter/material.dart';

class PoliticaDatosPage extends StatelessWidget {
  const PoliticaDatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Tratamiento de Datos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Política de Tratamiento de Datos Personales',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface)),
            const SizedBox(height: 4),
            Text('Última actualización: octubre 2026',
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
                'De conformidad con la Ley 1581 de 2012 y el Decreto 1377 de 2013 de la República de Colombia, FinanSys informa su política de tratamiento de datos personales.',
                style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.8),
                    height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
            _Seccion(
              numero: '1',
              titulo: 'Responsable del Tratamiento',
              contenido:
                  'FinanSys, aplicación de gestión de finanzas personales desarrollada como proyecto académico por estudiantes de la Universidad de Cundinamarca, es responsable del tratamiento de los datos personales recopilados a través de esta plataforma.',
            ),
            _Seccion(
              numero: '2',
              titulo: 'Datos Personales Recopilados',
              contenido:
                  'Recopilamos los siguientes datos personales:\n\n• Nombre completo\n• Nombre de usuario (username)\n• Correo electrónico\n• Contraseña (almacenada en formato cifrado con bcrypt)\n• Información financiera: ingresos, gastos, presupuestos y conversiones de divisas registradas por el usuario\n• Datos de actividad: fecha y hora de acceso, dirección IP',
            ),
            _Seccion(
              numero: '3',
              titulo: 'Finalidad del Tratamiento',
              contenido:
                  'Los datos personales recopilados se utilizan exclusivamente para:\n\n• Autenticación y acceso seguro a la cuenta\n• Prestación del servicio de gestión financiera personal\n• Personalización de la experiencia del usuario\n• Monitoreo de seguridad y detección de accesos no autorizados\n• Mejora continua del servicio',
            ),
            _Seccion(
              numero: '4',
              titulo: 'Derechos del Titular',
              contenido:
                  'Como titular de sus datos personales, usted tiene derecho a:\n\n• Conocer, actualizar y rectificar sus datos\n• Solicitar prueba de la autorización otorgada\n• Ser informado sobre el uso de sus datos\n• Revocar la autorización y solicitar la eliminación de sus datos\n• Acceder gratuitamente a sus datos personales\n\nPuede ejercer estos derechos directamente desde la configuración de su cuenta.',
            ),
            _Seccion(
              numero: '5',
              titulo: 'Seguridad de los Datos',
              contenido:
                  'Implementamos medidas técnicas y organizativas para proteger sus datos:\n\n• Contraseñas cifradas con algoritmo bcrypt (salt rounds: 10)\n• Autenticación mediante tokens JWT con expiración de 24 horas\n• Cierre automático de sesión por inactividad\n• Registro de accesos y actividad para auditoría\n• Comunicación cifrada mediante HTTPS',
            ),
            _Seccion(
              numero: '6',
              titulo: 'Compartición de Datos',
              contenido:
                  'Sus datos personales NO serán vendidos, arrendados ni compartidos con terceros con fines comerciales. Solo podrán ser divulgados en los siguientes casos:\n\n• Por orden judicial o requerimiento de autoridad competente\n• Cuando sea necesario para proteger los derechos de otros usuarios\n• Con proveedores de servicios técnicos estrictamente necesarios para el funcionamiento de la plataforma, bajo acuerdos de confidencialidad',
            ),
            _Seccion(
              numero: '7',
              titulo: 'Retención de Datos',
              contenido:
                  'Sus datos se conservarán mientras mantenga una cuenta activa en FinanSys. Al eliminar su cuenta, todos sus datos personales y financieros serán eliminados permanentemente de nuestros servidores en un plazo máximo de 30 días.',
            ),
            _Seccion(
              numero: '8',
              titulo: 'Cookies y Almacenamiento Local',
              contenido:
                  'FinanSys utiliza almacenamiento local del navegador (localStorage) exclusivamente para mantener la sesión del usuario mediante un token de autenticación. No utilizamos cookies de rastreo ni publicidad.',
            ),
            _Seccion(
              numero: '9',
              titulo: 'Transferencias Internacionales',
              contenido:
                  'Los datos son almacenados en servidores locales o en servicios de nube con sede en jurisdicciones que cuentan con estándares adecuados de protección de datos. No realizamos transferencias internacionales de datos sin las garantías adecuadas.',
            ),
            _Seccion(
              numero: '10',
              titulo: 'Cambios en la Política',
              contenido:
                  'Nos reservamos el derecho de actualizar esta política. Los cambios serán notificados a través de la aplicación. El uso continuado del servicio tras la notificación implica aceptación de la nueva política.',
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
                  'Al usar FinanSys usted autoriza el tratamiento de sus datos personales de acuerdo con esta política, en cumplimiento de la Ley 1581 de 2012.',
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
                child: const Text('Entendido'),
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
