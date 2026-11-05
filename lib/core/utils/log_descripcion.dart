// core/utils/log_descripcion.dart
// Traduce una petición registrada en los logs ("POST /api/v1/gastos") a una
// frase entendible para el administrador ("Registró un movimiento").

import '../../l10n/l10n.dart';

String describirAccion(
    AppLocalizations l10n, String metodo, String ruta, int? status) {
  var p = ruta.split('?').first;
  if (p.startsWith('/api/v1')) p = p.substring('/api/v1'.length);
  if (p.length > 1 && p.endsWith('/')) p = p.substring(0, p.length - 1);

  final m = metodo.toUpperCase();
  final fallo = status != null && status >= 400;
  bool es(String patron) => RegExp(patron).hasMatch(p);

  // ── Cuenta ──
  if (m == 'POST' && p == '/users/login') {
    return fallo ? l10n.logLoginFailed : l10n.logLoginOk;
  }
  if (m == 'POST' && p == '/users/register') {
    return fallo ? l10n.logRegisterFailed : l10n.logRegisterOk;
  }

  String base;
  if (m == 'POST' && p == '/users/logout') {
    base = l10n.logLogout;
  } else if (m == 'GET' && p == '/users/profile') {
    base = l10n.logProfileView;
  } else if (m == 'PUT' && p == '/users/profile') {
    base = l10n.logProfileUpdate;
  } else if (m == 'PUT' && p == '/users/tema') {
    base = l10n.logThemeChange;
  } else if (m == 'GET' && es(r'^/users/check-username/')) {
    base = l10n.logCheckUsername;
  } else if (m == 'POST' && p == '/users/forgot-password') {
    base = l10n.logForgotPassword;
  } else if (m == 'POST' && p == '/users/reset-password') {
    base = l10n.logResetPassword;
  } else if (m == 'GET' && p == '/users') {
    base = l10n.logUsersList;
  } else if (es(r'^/admin')) {
    base = l10n.logAdminPanel;
  }
  // ── Movimientos ──
  else if (m == 'POST' && p == '/gastos') {
    base = l10n.logMovementCreate;
  } else if (m == 'PUT' && es(r'^/gastos/\d+$')) {
    base = l10n.logMovementEdit;
  } else if (m == 'DELETE' && es(r'^/gastos/\d+$')) {
    base = l10n.logMovementDelete;
  } else if (m == 'GET' && es(r'^/gastos/reportes/exportar')) {
    base = ruta.contains('formato=pdf')
        ? l10n.logReportPdf
        : ruta.contains('formato=xlsx')
            ? l10n.logReportExcel
            : l10n.logReportDownload;
  } else if (m == 'GET' && es(r'^/gastos/reportes')) {
    base = l10n.logReportsView;
  } else if (m == 'GET' && es(r'^/gastos')) {
    base = l10n.logMovementsView;
  }
  // ── Categorías ──
  else if (es(r'^/categorias')) {
    base = switch (m) {
      'POST' => l10n.logCategoryCreate,
      'PUT' => l10n.logCategoryEdit,
      'DELETE' => l10n.logCategoryDelete,
      _ => l10n.logCategoriesView,
    };
  }
  // ── Presupuestos ──
  else if (es(r'^/presupuestos')) {
    base = switch (m) {
      'POST' => l10n.logBudgetSave,
      'PUT' => l10n.logBudgetEdit,
      'DELETE' => l10n.logBudgetDelete,
      _ => l10n.logBudgetsView,
    };
  }
  // ── Divisas y compras extranjeras ──
  else if (es(r'^/compras-extranjeras')) {
    base = switch (m) {
      'POST' => l10n.logForeignSave,
      'DELETE' => l10n.logForeignDelete,
      _ => l10n.logForeignView,
    };
  } else if (es(r'^/divisas')) {
    base = l10n.logRatesView;
  } else {
    base = '$m $p';
  }

  return fallo ? l10n.logWithError(base) : base;
}
