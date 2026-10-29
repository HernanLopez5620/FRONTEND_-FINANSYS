import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/gasto_provider.dart';
import 'presentation/providers/categoria_provider.dart';
import 'presentation/providers/presupuesto_provider.dart';
import 'presentation/providers/divisa_provider.dart';
import 'presentation/providers/compra_extranjera_provider.dart';
import 'presentation/providers/tema_provider.dart';
import 'presentation/pages/auth_page.dart';
import 'presentation/pages/dashboard_page.dart';

import 'presentation/providers/inactividad_provider.dart';
import 'presentation/providers/admin_provider.dart';
import 'presentation/providers/reporte_provider.dart';
import 'presentation/widgets/inactividad_detector.dart';
import 'presentation/widgets/inactividad_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await initializeDateFormatting('es', null);
  runApp(const FinanSysApp());
}

class FinanSysApp extends StatelessWidget {
  const FinanSysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemaProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GastoProvider()),
        ChangeNotifierProvider(create: (_) => CategoriaProvider()),
        ChangeNotifierProvider(create: (_) => PresupuestoProvider()),
        ChangeNotifierProvider(create: (_) => DivisaProvider()),
        ChangeNotifierProvider(create: (_) => CompraExtranjeraProvider()),
        // Aquí se agregó el provider de inactividad
        ChangeNotifierProvider(create: (_) => InactividadProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => ReporteProvider()),
      ],
      child: Consumer<TemaProvider>(
        builder: (_, temaP, __) => InactividadDetector(
          child: MaterialApp(
            title: 'FinanSys',
            debugShowCheckedModeBanner: false,
            theme: temaP.themeData,
            // Envolvemos la pantalla inicial con el overlay de inactividad
            home: const InactividadOverlay(child: _AuthGate()),
          ),
        ),
      ),
    );
  }
}

class _AuthGate extends StatefulWidget {
  const _AuthGate();
  @override
  State<_AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<_AuthGate> {
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await context.read<AuthProvider>().checkAuthStatus();
    final user = context.read<AuthProvider>().user;
    if (user != null) {
      context.read<TemaProvider>().cargarDesdeUsuario(user.tema);
    }
    setState(() => _checking = false);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_checking) {
      return Scaffold(
        backgroundColor: cs.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet_rounded,
                  color: cs.onPrimary, size: 60),
              const SizedBox(height: 16),
              Text('FinanSys',
                  style: TextStyle(
                      color: cs.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 32),
              CircularProgressIndicator(
                  color: cs.onPrimary.withOpacity(0.7), strokeWidth: 2),
            ],
          ),
        ),
      );
    }
    return Consumer<AuthProvider>(
      builder: (_, auth, __) =>
          auth.isAuthenticated ? const DashboardPage() : const AuthPage(),
    );
  }
}
