import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'l10n/l10n.dart';

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
import 'presentation/providers/backup_provider.dart';
import 'presentation/providers/idioma_provider.dart';
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
  // Datos de fechas para todos los idiomas disponibles
  for (final l in IdiomaProvider.soportados) {
    await initializeDateFormatting(l.languageCode, null);
  }
  // Idioma guardado por el usuario (antes de dibujar la primera pantalla)
  final idioma = IdiomaProvider();
  await idioma.cargar();
  runApp(FinanSysApp(idioma: idioma));
}

class FinanSysApp extends StatelessWidget {
  final IdiomaProvider idioma;
  const FinanSysApp({super.key, required this.idioma});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: idioma),
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
        ChangeNotifierProvider(create: (_) => BackupProvider()),
      ],
      child: Consumer2<TemaProvider, IdiomaProvider>(
        builder: (_, temaP, idiomaP, __) => InactividadDetector(
          child: MaterialApp(
            onGenerateTitle: (ctx) => ctx.l10n.appTitle,
            debugShowCheckedModeBanner: false,
            // Idioma activo (se cambia desde el selector, sin recargar)
            locale: idiomaP.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
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
