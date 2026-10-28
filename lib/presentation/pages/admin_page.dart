// presentation/pages/admin_page.dart
// SOLID-SRP: panel de administración (solo cuentas con rol 'admin').
// Muestra indicadores, la lista de usuarios y su actividad. Nunca muestra contraseñas.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/log_descripcion.dart';
import '../../domain/entities/admin_entities.dart';
import '../providers/admin_logs_controller.dart';
import '../providers/admin_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/inactividad_overlay.dart';

final _fechaHora = DateFormat('dd/MM/yyyy HH:mm:ss');
final _fechaCorta = DateFormat('dd/MM HH:mm:ss');
final _soloFecha = DateFormat('dd/MM/yyyy');

String _hace(DateTime? d) {
  if (d == null) return 'Sin actividad';
  final dif = DateTime.now().difference(d);
  if (dif.inSeconds < 60) return 'Hace un momento';
  if (dif.inMinutes < 60) return 'Hace ${dif.inMinutes} min';
  if (dif.inHours < 24) return 'Hace ${dif.inHours} h';
  if (dif.inDays < 30) return 'Hace ${dif.inDays} d';
  return _soloFecha.format(d);
}

// ───────────────────────── Envoltorio común ─────────────────────────
// Aviso de inactividad encima de la pantalla y regreso al inicio si la sesión se cierra.
class _AdminShell extends StatelessWidget {
  final Widget child;
  const _AdminShell({required this.child});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (!auth.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Navigator.of(context).popUntil((r) => r.isFirst);
        }
      });
    }
    return InactividadOverlay(child: child);
  }
}

// ───────────────────────── Pantalla principal ─────────────────────────
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  late final AdminProvider _admin;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
    _admin = context.read<AdminProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _admin.cargarTodo());
  }

  @override
  void dispose() {
    _tab.dispose();
    // Se difiere para no notificar mientras el árbol se desmonta
    Future.microtask(_admin.limpiar);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = theme.appBarTheme.foregroundColor ?? theme.colorScheme.onSurface;

    return _AdminShell(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Administración'),
          actions: [
            IconButton(
              tooltip: 'Actualizar',
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _admin.cargarTodo,
            ),
          ],
          bottom: TabBar(
            controller: _tab,
            labelColor: fg,
            unselectedLabelColor: fg.withOpacity(0.65),
            indicatorColor: fg,
            tabs: const [
              Tab(icon: Icon(Icons.dashboard_outlined), text: 'Resumen'),
              Tab(icon: Icon(Icons.people_outline_rounded), text: 'Usuarios'),
              Tab(icon: Icon(Icons.history_rounded), text: 'Actividad'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tab,
          children: const [
            _ResumenTab(),
            _UsuariosTab(),
            AdminLogsView(mostrarUsuario: true),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Pestaña: Resumen ─────────────────────────
class _ResumenTab extends StatelessWidget {
  const _ResumenTab();

  @override
  Widget build(BuildContext context) {
    final a = context.watch<AdminProvider>();
    final cs = Theme.of(context).colorScheme;

    if (a.cargandoResumen && a.resumen == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (a.resumen == null) {
      return _Mensaje(
        icono: Icons.error_outline_rounded,
        texto: a.errorResumen ?? 'No se pudo cargar el resumen',
        onReintentar: a.cargarResumen,
      );
    }

    final r = a.resumen!;
    final ancho = MediaQuery.of(context).size.width;
    final columnas = ancho > 900 ? 3 : 2;

    return RefreshIndicator(
      onRefresh: () => a.cargarResumen(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columnas,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _StatCard(
                  icono: Icons.people_alt_rounded,
                  valor: r.totalUsuarios,
                  etiqueta: 'Usuarios registrados'),
              _StatCard(
                  icono: Icons.login_rounded,
                  valor: r.sesionesAbiertas,
                  etiqueta: 'Sesiones abiertas'),
              _StatCard(
                  icono: Icons.person_add_alt_1_rounded,
                  valor: r.nuevos7d,
                  etiqueta: 'Nuevos (7 días)'),
              _StatCard(
                  icono: Icons.bolt_rounded,
                  valor: r.activos24h,
                  etiqueta: 'Activos (24 h)'),
              _StatCard(
                  icono: Icons.swap_vert_rounded,
                  valor: r.requests24h,
                  etiqueta: 'Peticiones (24 h)'),
              _StatCard(
                  icono: Icons.warning_amber_rounded,
                  valor: r.errores24h,
                  etiqueta: 'Errores (24 h)',
                  color: r.errores24h > 0 ? AppTheme.warning : null),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            Icon(Icons.lock_outline_rounded,
                size: 16, color: cs.onSurface.withOpacity(0.5)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Por seguridad, este panel nunca muestra contraseñas.',
                style: TextStyle(
                    fontSize: 12, color: cs.onSurface.withOpacity(0.5)),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icono;
  final int valor;
  final String etiqueta;
  final Color? color;

  const _StatCard({
    required this.icono,
    required this.valor,
    required this.etiqueta,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final c = color ?? cs.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icono, color: c, size: 26),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              NumberFormat.decimalPattern('es').format(valor),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface),
            ),
            Text(
              etiqueta,
              style:
                  TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(0.6)),
            ),
          ]),
        ],
      ),
    );
  }
}

// ───────────────────────── Pestaña: Usuarios ─────────────────────────
class _UsuariosTab extends StatefulWidget {
  const _UsuariosTab();

  @override
  State<_UsuariosTab> createState() => _UsuariosTabState();
}

class _UsuariosTabState extends State<_UsuariosTab> {
  final _ctrl = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  void _alEscribir(String texto) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (mounted) context.read<AdminProvider>().buscar(texto);
    });
  }

  @override
  Widget build(BuildContext context) {
    final a = context.watch<AdminProvider>();
    final cs = Theme.of(context).colorScheme;

    Widget lista;
    if (a.cargandoUsuarios && a.usuarios.isEmpty) {
      lista = const Center(child: CircularProgressIndicator());
    } else if (a.errorUsuarios != null && a.usuarios.isEmpty) {
      lista = _Mensaje(
        icono: Icons.error_outline_rounded,
        texto: a.errorUsuarios!,
        onReintentar: a.cargarUsuarios,
      );
    } else if (a.usuarios.isEmpty) {
      lista = const _Mensaje(
        icono: Icons.search_off_rounded,
        texto: 'No se encontraron usuarios',
      );
    } else {
      lista = RefreshIndicator(
        onRefresh: () => a.cargarUsuarios(),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          itemCount: a.usuarios.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => _UsuarioTile(usuario: a.usuarios[i]),
        ),
      );
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: TextField(
          controller: _ctrl,
          onChanged: _alEscribir,
          decoration: InputDecoration(
            hintText: 'Buscar por nombre, usuario o correo',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: _ctrl.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      _ctrl.clear();
                      _debounce?.cancel();
                      context.read<AdminProvider>().buscar('');
                      setState(() {});
                    },
                  ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${a.usuarios.length} usuario${a.usuarios.length == 1 ? '' : 's'}',
            style:
                TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(0.55)),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Expanded(child: lista),
    ]);
  }
}

class _UsuarioTile extends StatelessWidget {
  final AdminUsuario usuario;
  const _UsuarioTile({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final u = usuario;
    final inicial = (u.nombre.isNotEmpty ? u.nombre : u.username);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => _UsuarioLogsPage(usuario: u)),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
        ),
        child: Row(children: [
          Stack(children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: cs.primary,
              child: Text(
                inicial.isEmpty ? '?' : inicial[0].toUpperCase(),
                style: TextStyle(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: u.enLinea ? AppTheme.success : Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.cardColor, width: 2),
                ),
              ),
            ),
          ]),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Flexible(
                    child: Text(
                      u.nombre.isEmpty ? u.username : u.nombre,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: cs.onSurface),
                    ),
                  ),
                  if (u.esAdmin) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: cs.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Admin',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: cs.primary)),
                    ),
                  ],
                ]),
                const SizedBox(height: 2),
                Text(
                  '@${u.username} · ${u.email}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12, color: cs.onSurface.withOpacity(0.6)),
                ),
                const SizedBox(height: 2),
                Text(
                  u.enLinea ? 'En línea' : _hace(u.ultimaActividad),
                  style: TextStyle(
                      fontSize: 11,
                      color: u.enLinea
                          ? AppTheme.success
                          : cs.onSurface.withOpacity(0.45)),
                ),
              ],
            ),
          ),
          Column(children: [
            Text('${u.totalAcciones}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface)),
            Text('acciones',
                style: TextStyle(
                    fontSize: 10, color: cs.onSurface.withOpacity(0.5))),
          ]),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right_rounded,
              color: cs.onSurface.withOpacity(0.4)),
        ]),
      ),
    );
  }
}

// ─────────────── Detalle de un usuario: su actividad ───────────────
class _UsuarioLogsPage extends StatelessWidget {
  final AdminUsuario usuario;
  const _UsuarioLogsPage({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final u = usuario;

    Widget dato(String etiqueta, String valor) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: 110,
              child: Text(etiqueta,
                  style: TextStyle(
                      fontSize: 12, color: cs.onSurface.withOpacity(0.55))),
            ),
            Expanded(
              child: Text(valor,
                  style: TextStyle(fontSize: 12, color: cs.onSurface)),
            ),
          ]),
        );

    return _AdminShell(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(title: Text(u.nombre.isEmpty ? u.username : u.nombre)),
        body: Column(children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              dato('Usuario', '@${u.username}'),
              dato('Correo', u.email),
              dato('Rol', u.esAdmin ? 'Administrador' : 'Usuario'),
              dato('Registrado',
                  u.createdAt == null ? '—' : _soloFecha.format(u.createdAt!)),
              dato('Estado', u.enLinea ? 'En línea' : _hace(u.ultimaActividad)),
              dato('Sesión', u.sesionAbierta ? 'Abierta' : 'Cerrada'),
              dato('Acciones', '${u.totalAcciones} registradas'),
            ]),
          ),
          Expanded(child: AdminLogsView(uid: u.uid)),
        ]),
      ),
    );
  }
}

// ───────────────────────── Lista de logs ─────────────────────────
class AdminLogsView extends StatefulWidget {
  /// Si se indica, solo muestra la actividad de ese usuario.
  final int? uid;

  /// Muestra a qué usuario pertenece cada registro (para la vista general).
  final bool mostrarUsuario;

  const AdminLogsView({super.key, this.uid, this.mostrarUsuario = false});

  @override
  State<AdminLogsView> createState() => _AdminLogsViewState();
}

class _AdminLogsViewState extends State<AdminLogsView> {
  late final LogsController _c;

  @override
  void initState() {
    super.initState();
    _c = LogsController(uid: widget.uid);
    _c.cargar();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _filtros() {
    const metodos = <String?>[null, 'GET', 'POST', 'PUT', 'DELETE'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(children: [
        for (final m in metodos) ...[
          ChoiceChip(
            label: Text(m ?? 'Todos'),
            selected: _c.metodo == m,
            onSelected: (_) => _c.setMetodo(m),
          ),
          const SizedBox(width: 8),
        ],
        FilterChip(
          avatar: const Icon(Icons.error_outline_rounded, size: 16),
          label: const Text('Solo errores'),
          selected: _c.soloErrores,
          onSelected: _c.setSoloErrores,
        ),
      ]),
    );
  }

  Widget _contenido() {
    final cs = Theme.of(context).colorScheme;

    if (_c.cargando && _c.logs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_c.error != null && _c.logs.isEmpty) {
      return _Mensaje(
        icono: Icons.error_outline_rounded,
        texto: _c.error!,
        onReintentar: _c.cargar,
      );
    }
    if (_c.logs.isEmpty) {
      return const _Mensaje(
        icono: Icons.inbox_outlined,
        texto: 'Sin actividad registrada',
      );
    }

    return RefreshIndicator(
      onRefresh: () => _c.cargar(),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        itemCount: _c.logs.length + 1,
        itemBuilder: (_, i) {
          if (i < _c.logs.length) {
            return _LogTile(
                log: _c.logs[i], mostrarUsuario: widget.mostrarUsuario);
          }
          // Pie de la lista
          if (_c.hayMas) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: _c.cargando
                    ? const CircularProgressIndicator()
                    : OutlinedButton(
                        onPressed: _c.cargarMas,
                        child: Text(
                            'Cargar más (${_c.logs.length} de ${_c.total})'),
                      ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Text('${_c.total} registros en total',
                  style: TextStyle(
                      fontSize: 11, color: cs.onSurface.withOpacity(0.45))),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Column(children: [
        _filtros(),
        Expanded(child: _contenido()),
      ]),
    );
  }
}

class _LogTile extends StatelessWidget {
  final LogEntry log;
  final bool mostrarUsuario;
  const _LogTile({required this.log, required this.mostrarUsuario});

  Color _colorEstado() {
    final s = log.statusCode ?? 0;
    if (s >= 500) return AppTheme.danger;
    if (s >= 400) return AppTheme.warning;
    return AppTheme.success;
  }

  IconData _iconoEstado() {
    final s = log.statusCode ?? 0;
    if (s >= 500) return Icons.dangerous_rounded;
    if (s >= 400) return Icons.warning_amber_rounded;
    return Icons.check_circle_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final color = _colorEstado();
    final detalle = [
      if (log.ip != null && log.ip!.isNotEmpty) 'IP ${log.ip}',
      if (log.duracionMs != null) '${log.duracionMs} ms',
    ].join('  ·  ');

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(_iconoEstado(), color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              describirAccion(log.metodo, log.ruta, log.statusCode),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface),
            ),
            if (mostrarUsuario)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  log.username != null
                      ? '@${log.username}'
                      : 'Sin sesión (anónimo)',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: cs.primary),
                ),
              ),
            const SizedBox(height: 2),
            Text(
              '${log.metodo} ${log.ruta}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 11, color: cs.onSurface.withOpacity(0.55)),
            ),
            if (detalle.isNotEmpty)
              Text(detalle,
                  style: TextStyle(
                      fontSize: 11, color: cs.onSurface.withOpacity(0.45))),
          ]),
        ),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('${log.statusCode ?? '—'}',
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 2),
          Text(
            log.createdAt == null ? '' : _fechaCorta.format(log.createdAt!),
            style:
                TextStyle(fontSize: 10, color: cs.onSurface.withOpacity(0.5)),
          ),
        ]),
      ]),
    );
  }
}

// ───────────────────────── Mensaje / error ─────────────────────────
class _Mensaje extends StatelessWidget {
  final IconData icono;
  final String texto;
  final Future<void> Function()? onReintentar;

  const _Mensaje({required this.icono, required this.texto, this.onReintentar});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icono, size: 48, color: cs.onSurface.withOpacity(0.35)),
          const SizedBox(height: 12),
          Text(texto,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurface.withOpacity(0.65))),
          if (onReintentar != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => onReintentar!(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Reintentar'),
            ),
          ],
        ]),
      ),
    );
  }
}
