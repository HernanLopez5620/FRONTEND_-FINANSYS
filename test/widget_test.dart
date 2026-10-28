// Prueba básica de la aplicación FinanSys.
//
// Se verifica que el widget principal de la aplicación
// puede construirse correctamente.

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/main.dart';

void main() {
  testWidgets('FinanSysApp se construye correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FinanSysApp());

    // Permite que se complete el primer ciclo de construcción
    // de la aplicación y sus providers.
    await tester.pump();

    expect(find.text('FinanSys'), findsOneWidget);
  });
}
