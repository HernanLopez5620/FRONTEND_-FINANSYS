// core/utils/log_descripcion.dart
// Traduce una petición registrada en los logs ("POST /api/v1/gastos") a una
// frase entendible para el administrador ("Registró un movimiento").

String describirAccion(String metodo, String ruta, int? status) {
  var p = ruta.split('?').first;
  if (p.startsWith('/api/v1')) p = p.substring('/api/v1'.length);
  if (p.length > 1 && p.endsWith('/')) p = p.substring(0, p.length - 1);

  final m = metodo.toUpperCase();
  final fallo = status != null && status >= 400;
  bool es(String patron) => RegExp(patron).hasMatch(p);

  // ── Cuenta ──
  if (m == 'POST' && p == '/users/login') {
    return fallo ? 'Intento de inicio de sesión fallido' : 'Inició sesión';
  }
  if (m == 'POST' && p == '/users/register') {
    return fallo ? 'Registro fallido' : 'Creó su cuenta';
  }

  String base;
  if (m == 'POST' && p == '/users/logout') {
    base = 'Cerró sesión';
  } else if (m == 'GET' && p == '/users/profile') {
    base = 'Consultó su perfil';
  } else if (m == 'PUT' && p == '/users/profile') {
    base = 'Actualizó su perfil';
  } else if (m == 'PUT' && p == '/users/tema') {
    base = 'Cambió el tema';
  } else if (m == 'GET' && es(r'^/users/check-username/')) {
    base = 'Verificó un nombre de usuario';
  } else if (m == 'POST' && p == '/users/forgot-password') {
    base = 'Pidió restablecer su contraseña';
  } else if (m == 'POST' && p == '/users/reset-password') {
    base = 'Restableció su contraseña';
  } else if (m == 'GET' && p == '/users') {
    base = 'Consultó la lista de usuarios';
  } else if (es(r'^/admin')) {
    base = 'Consultó el panel de administración';
  }
  // ── Movimientos ──
  else if (m == 'POST' && p == '/gastos') {
    base = 'Registró un movimiento';
  } else if (m == 'PUT' && es(r'^/gastos/\d+$')) {
    base = 'Editó un movimiento';
  } else if (m == 'DELETE' && es(r'^/gastos/\d+$')) {
    base = 'Eliminó un movimiento';
  } else if (m == 'GET' && es(r'^/gastos/reportes')) {
    base = 'Consultó reportes';
  } else if (m == 'GET' && es(r'^/gastos')) {
    base = 'Consultó sus movimientos';
  }
  // ── Categorías ──
  else if (es(r'^/categorias')) {
    base = switch (m) {
      'POST' => 'Creó una categoría',
      'PUT' => 'Editó una categoría',
      'DELETE' => 'Eliminó una categoría',
      _ => 'Consultó sus categorías',
    };
  }
  // ── Presupuestos ──
  else if (es(r'^/presupuestos')) {
    base = switch (m) {
      'POST' => 'Guardó un presupuesto',
      'PUT' => 'Editó un presupuesto',
      'DELETE' => 'Eliminó un presupuesto',
      _ => 'Consultó sus presupuestos',
    };
  }
  // ── Divisas y compras extranjeras ──
  else if (es(r'^/compras-extranjeras')) {
    base = switch (m) {
      'POST' => 'Guardó una compra extranjera',
      'DELETE' => 'Eliminó una compra extranjera',
      _ => 'Consultó sus compras extranjeras',
    };
  } else if (es(r'^/divisas')) {
    base = 'Consultó tasas de cambio';
  } else {
    base = '$m $p';
  }

  return fallo ? '$base (con error)' : base;
}
