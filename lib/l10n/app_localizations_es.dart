// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonAccept => 'Aceptar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String get commonYes => 'Sí';

  @override
  String get commonNo => 'No';

  @override
  String get appTitle => 'FinanSys';

  @override
  String get dashRegister => 'Registrar';

  @override
  String get dashMonthlyComparison => 'Comparación mensual';

  @override
  String get dashExpensesByCategory => 'Gastos por categoría';

  @override
  String get dashLatestMovements => 'Últimos movimientos';

  @override
  String get dashSeeAll => 'Ver todos';

  @override
  String get dashNoMovementsMonth => 'Sin movimientos este mes';

  @override
  String get dashTapPlusFirst => 'Toca + para registrar el primero';

  @override
  String get gastosFilterAll => 'Todos';

  @override
  String get gastosFilterExpenses => 'Gastos';

  @override
  String get gastosFilterIncome => 'Ingresos';

  @override
  String get gastosEmptyTitle => 'Sin movimientos';

  @override
  String get gastosEmptySubtitle => 'Toca + para registrar uno';

  @override
  String get gastosDeleteTitle => 'Eliminar movimiento';

  @override
  String gastosDeleteConfirm(String name) {
    return '¿Seguro que quieres eliminar \"$name\"?';
  }

  @override
  String get gastosThisMovement => 'este movimiento';

  @override
  String get catEmptyTitle => 'Sin categorías';

  @override
  String get catEmptySubtitle => 'Crea tu primera categoría';

  @override
  String get catCreate => 'Crear categoría';

  @override
  String get budgetEmptyTitle => 'Sin presupuestos';

  @override
  String get budgetEmptySubtitle => 'Define límites por categoría';

  @override
  String get budgetCreate => 'Crear presupuesto';

  @override
  String get budgetMonthTitle => 'Presupuesto del mes';

  @override
  String get headerViewProfile => 'Ver perfil';

  @override
  String get headerAdmin => 'Administración';

  @override
  String get headerLogout => 'Cerrar sesión';

  @override
  String get headerLogoutConfirm => '¿Estás seguro que deseas cerrar sesión?';

  @override
  String get headerDebtWarning => 'Tienes deudas este mes';

  @override
  String get headerBalanceAvailable => 'Balance disponible';

  @override
  String get headerIncome => 'Ingresos';

  @override
  String get headerExpenses => 'Gastos';

  @override
  String get headerSavings => 'Ahorro';

  @override
  String get navHome => 'Inicio';

  @override
  String get navMovements => 'Movimientos';

  @override
  String get navReports => 'Reportes';

  @override
  String get navCategories => 'Categorías';

  @override
  String get navBudgets => 'Presupuestos';

  @override
  String get navCurrencies => 'Divisas';

  @override
  String get authLoginTab => 'Iniciar sesión';

  @override
  String get authRegisterTab => 'Registrarse';

  @override
  String get authTagline => 'Tus finanzas bajo control';

  @override
  String get authLoginError => 'Error al iniciar sesión';

  @override
  String get authEmailOrUser => 'Correo o usuario';

  @override
  String get authEmailOrUserRequired => 'Ingresa tu correo o usuario';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authPasswordRequired => 'Ingresa tu contraseña';

  @override
  String get authLoginButton => 'Ingresar';

  @override
  String get authUsernameHint => 'Solo letras, números y _ (3-20 caracteres)';

  @override
  String get authMustAcceptTerms =>
      'Debes aceptar los Términos y la Política de Datos';

  @override
  String get authUsernameUnavailable => 'El username no está disponible';

  @override
  String get authRegisterError => 'Error al registrarse';

  @override
  String get authFullName => 'Nombre completo';

  @override
  String get authNameRequired => 'Ingresa tu nombre';

  @override
  String get authUsernameLabel => 'Usuario (ej: JuanCa123)';

  @override
  String get authUsernameRequired => 'Ingresa un usuario';

  @override
  String get authEmail => 'Correo electrónico';

  @override
  String get authEmailInvalid => 'Correo inválido';

  @override
  String get authPasswordMin => 'Mínimo 6 caracteres';

  @override
  String get authConfirmPassword => 'Confirmar contraseña';

  @override
  String get authPasswordsMismatch => 'Las contraseñas no coinciden';

  @override
  String get authAcceptPrefix => 'He leído y acepto los ';

  @override
  String get authTermsLink => 'Términos y Condiciones';

  @override
  String get authAuthorizePrefix => 'Autorizo el ';

  @override
  String get authPersonalDataLink => 'Tratamiento de mis Datos Personales';

  @override
  String get authRegisterButton => 'Registrarme';

  @override
  String get authGoogleLoginError => 'No se pudo iniciar sesión con Google';

  @override
  String get authGoogleLoadError => 'No se pudo cargar el inicio con Google';

  @override
  String get authOr => 'o';

  @override
  String get authGoogleTermsNotice =>
      'Al continuar con Google aceptas los Términos y la Política de datos de FinanSys.';

  @override
  String get sessionReplacedNotice =>
      'Tu cuenta se abrió en otra ventana o dispositivo, por eso se cerró esta sesión.';

  @override
  String get sessionInvalidNotice =>
      'Tu sesión ya no es válida. Inicia sesión de nuevo.';

  @override
  String get sessionStillThereTitle => '¿Sigues ahí?';

  @override
  String get sessionWillCloseIn => 'Tu sesión se cerrará por inactividad en:';

  @override
  String get sessionContinueButton => 'Continuar sesión';

  @override
  String get sessionClosedTitle => 'Sesión cerrada';

  @override
  String get sessionClosedInactivity =>
      'Tu sesión fue cerrada por inactividad.';

  @override
  String get sessionCanLoginIn => 'Podrás ingresar en:';

  @override
  String sessionSecondsShort(int segundos) {
    return '${segundos}s';
  }

  @override
  String get sessionWaitSecurityNotice =>
      'Por tu seguridad debes esperar antes de volver a iniciar sesión.';

  @override
  String get profileTitle => 'Mi perfil';

  @override
  String get profileUpdated => 'Perfil actualizado';

  @override
  String get profileUpdateError => 'No se pudo actualizar el perfil';

  @override
  String get profileAccountActive => '✅ Cuenta activa';

  @override
  String get profileAccountInactive => '❌ Cuenta inactiva';

  @override
  String profileMemberSince(String fecha) {
    return 'Miembro desde $fecha';
  }

  @override
  String get profilePersonalData => 'Datos personales';

  @override
  String get profileUsername => 'Usuario';

  @override
  String get profileUsernameRequired => 'Ingresa un nombre de usuario';

  @override
  String get profileChangePasswordOptional => 'Cambiar contraseña (opcional)';

  @override
  String get profileNewPassword => 'Nueva contraseña';

  @override
  String get profileSaveChanges => 'Guardar cambios';

  @override
  String get profileAppearance => 'Apariencia';

  @override
  String get profileThemeLight => 'Claro';

  @override
  String get profileThemeDark => 'Oscuro';

  @override
  String get profileThemeGamer => 'Gamer';

  @override
  String get profileMyData => 'Mis datos';

  @override
  String get profileBackupDescription =>
      'Descarga una copia de tus datos (perfil, categorías, movimientos, presupuestos y compras en el extranjero) en un archivo JSON. No incluye contraseñas.';

  @override
  String get profileBackupDownloaded => 'Copia de seguridad descargada';

  @override
  String get profileBackupError => 'No se pudo descargar la copia';

  @override
  String get profileBackupGenerating => 'Generando...';

  @override
  String get profileBackupDownload => 'Descargar mis datos';

  @override
  String get profileLegalInfo => 'Información legal';

  @override
  String get profileDataPolicy => 'Política de tratamiento de datos';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get adminTitle => 'Administración';

  @override
  String get adminRefreshTooltip => 'Actualizar';

  @override
  String get adminTabSummary => 'Resumen';

  @override
  String get adminTabUsers => 'Usuarios';

  @override
  String get adminTabActivity => 'Actividad';

  @override
  String get adminSummaryLoadError => 'No se pudo cargar el resumen';

  @override
  String get adminStatUsers => 'Usuarios registrados';

  @override
  String get adminStatSessions => 'Sesiones abiertas';

  @override
  String get adminStatNew7d => 'Nuevos (7 días)';

  @override
  String get adminStatActive24h => 'Activos (24 h)';

  @override
  String get adminStatRequests24h => 'Peticiones (24 h)';

  @override
  String get adminStatErrors24h => 'Errores (24 h)';

  @override
  String get adminSecurityNote =>
      'Por seguridad, este panel nunca muestra contraseñas.';

  @override
  String get adminNoUsersFound => 'No se encontraron usuarios';

  @override
  String get adminSearchHint => 'Buscar por nombre, usuario o correo';

  @override
  String adminUserCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count usuarios',
      one: '1 usuario',
    );
    return '$_temp0';
  }

  @override
  String get adminAdminBadge => 'Admin';

  @override
  String get adminOnline => 'En línea';

  @override
  String get adminActionsUnit => 'acciones';

  @override
  String get adminNoActivityYet => 'Sin actividad';

  @override
  String get adminAgoNow => 'Hace un momento';

  @override
  String adminAgoMinutes(int n) {
    return 'Hace $n min';
  }

  @override
  String adminAgoHours(int n) {
    return 'Hace $n h';
  }

  @override
  String adminAgoDays(int n) {
    return 'Hace $n d';
  }

  @override
  String get adminDetailUser => 'Usuario';

  @override
  String get adminDetailEmail => 'Correo';

  @override
  String get adminDetailRole => 'Rol';

  @override
  String get adminRoleAdmin => 'Administrador';

  @override
  String get adminRoleUser => 'Usuario';

  @override
  String get adminDetailRegistered => 'Registrado';

  @override
  String get adminDetailStatus => 'Estado';

  @override
  String get adminDetailSession => 'Sesión';

  @override
  String get adminSessionOpen => 'Abierta';

  @override
  String get adminSessionClosed => 'Cerrada';

  @override
  String get adminDetailActions => 'Acciones';

  @override
  String adminActionsRegistered(int count) {
    return '$count registradas';
  }

  @override
  String get adminFilterAll => 'Todos';

  @override
  String get adminFilterOnlyErrors => 'Solo errores';

  @override
  String get adminNoActivityRecorded => 'Sin actividad registrada';

  @override
  String adminLoadMore(String shown, String total) {
    return 'Cargar más ($shown de $total)';
  }

  @override
  String adminTotalRecords(String total) {
    return '$total registros en total';
  }

  @override
  String get adminLogAnonymous => 'Sin sesión (anónimo)';

  @override
  String get logLoginFailed => 'Intento de inicio de sesión fallido';

  @override
  String get logLoginOk => 'Inició sesión';

  @override
  String get logRegisterFailed => 'Registro fallido';

  @override
  String get logRegisterOk => 'Creó su cuenta';

  @override
  String get logLogout => 'Cerró sesión';

  @override
  String get logProfileView => 'Consultó su perfil';

  @override
  String get logProfileUpdate => 'Actualizó su perfil';

  @override
  String get logThemeChange => 'Cambió el tema';

  @override
  String get logCheckUsername => 'Verificó un nombre de usuario';

  @override
  String get logForgotPassword => 'Pidió restablecer su contraseña';

  @override
  String get logResetPassword => 'Restableció su contraseña';

  @override
  String get logUsersList => 'Consultó la lista de usuarios';

  @override
  String get logAdminPanel => 'Consultó el panel de administración';

  @override
  String get logMovementCreate => 'Registró un movimiento';

  @override
  String get logMovementEdit => 'Editó un movimiento';

  @override
  String get logMovementDelete => 'Eliminó un movimiento';

  @override
  String get logReportPdf => 'Descargó un reporte en PDF';

  @override
  String get logReportExcel => 'Descargó un reporte en Excel';

  @override
  String get logReportDownload => 'Descargó un reporte';

  @override
  String get logReportsView => 'Consultó reportes';

  @override
  String get logMovementsView => 'Consultó sus movimientos';

  @override
  String get logCategoryCreate => 'Creó una categoría';

  @override
  String get logCategoryEdit => 'Editó una categoría';

  @override
  String get logCategoryDelete => 'Eliminó una categoría';

  @override
  String get logCategoriesView => 'Consultó sus categorías';

  @override
  String get logBudgetSave => 'Guardó un presupuesto';

  @override
  String get logBudgetEdit => 'Editó un presupuesto';

  @override
  String get logBudgetDelete => 'Eliminó un presupuesto';

  @override
  String get logBudgetsView => 'Consultó sus presupuestos';

  @override
  String get logForeignSave => 'Guardó una compra extranjera';

  @override
  String get logForeignDelete => 'Eliminó una compra extranjera';

  @override
  String get logForeignView => 'Consultó sus compras extranjeras';

  @override
  String get logRatesView => 'Consultó tasas de cambio';

  @override
  String logWithError(String base) {
    return '$base (con error)';
  }

  @override
  String get divisasFillNameFirst =>
      'Completa el nombre y realiza una conversión primero';

  @override
  String get divisasSaved => '✅ Compra guardada';

  @override
  String get divisasSaveError => '❌ Error al guardar';

  @override
  String get divisasCalcTitle => 'Calculadora de divisas';

  @override
  String get divisasAutoUpdate => 'El resultado se actualiza automáticamente';

  @override
  String get divisasFrom => 'De';

  @override
  String get divisasAmount => 'Monto';

  @override
  String get divisasTo => 'A';

  @override
  String get divisasPurchaseNameLabel =>
      'Nombre de la compra (ej: Camiseta Nike)';

  @override
  String get divisasSavePurchase => 'Guardar compra';

  @override
  String get divisasSavedTitle => 'Compras guardadas';

  @override
  String get divisasEmpty => 'Sin compras guardadas';

  @override
  String get divisasDeleteTitle => 'Eliminar compra';

  @override
  String divisasDeleteConfirm(String nombre) {
    return '¿Seguro que quieres eliminar \"$nombre\"?';
  }

  @override
  String get reportTabByCategory => 'Por categoría';

  @override
  String get reportTabMonthly => 'Mensual';

  @override
  String get reportDistribution => 'Distribución de gastos';

  @override
  String get reportNoDataMonth => 'Sin datos este mes';

  @override
  String get reportDetailByCategory => 'Detalle por categoría';

  @override
  String get reportIncomeVsExpenses => 'Ingresos vs. Gastos';

  @override
  String get reportNoData => 'Sin datos';

  @override
  String get reportMonthlyComparison => 'Comparativa mensual';

  @override
  String get reportIncome => 'Ingresos';

  @override
  String get reportExpenses => 'Gastos';

  @override
  String get reportBalance => 'Balance';

  @override
  String reportDownloaded(String formato) {
    return 'Reporte descargado ($formato)';
  }

  @override
  String get reportExportFailed => 'No se pudo exportar el reporte';

  @override
  String get reportExportTooltip => 'Exportar reporte';

  @override
  String reportOfMonth(String mes) {
    return 'Reporte de $mes';
  }

  @override
  String get reportDownloadPdf => 'Descargar PDF';

  @override
  String get reportDownloadExcel => 'Descargar Excel';

  @override
  String get reportFilePrefix => 'FinanSys_reporte';

  @override
  String get gastoFormSelectCategory => 'Selecciona una categoría';

  @override
  String get gastoFormEdit => 'Editar movimiento';

  @override
  String get gastoFormNew => 'Nuevo movimiento';

  @override
  String get gastoFormTabExpense => 'Gasto';

  @override
  String get gastoFormTabIncome => 'Ingreso';

  @override
  String get gastoFormAmount => 'Monto';

  @override
  String get gastoFormDescription => 'Descripción (opcional)';

  @override
  String get gastoFormCategory => 'Categoría';

  @override
  String get gastoFormNoCategories => 'Sin categorías para este tipo';

  @override
  String get gastoFormUpdate => 'Actualizar';

  @override
  String get catFormTitle => 'Nueva categoría';

  @override
  String get catFormName => 'Nombre';

  @override
  String get catFormType => 'Tipo';

  @override
  String get catFormTypeExpense => 'gasto';

  @override
  String get catFormTypeIncome => 'ingreso';

  @override
  String get catFormIcon => 'Ícono';

  @override
  String get catFormColor => 'Color';

  @override
  String get catFormCreate => 'Crear categoría';

  @override
  String get budgetFormTitle => 'Nuevo presupuesto';

  @override
  String get budgetFormCategory => 'Categoría';

  @override
  String get budgetFormLimit => 'Monto límite';

  @override
  String get budgetFormSave => 'Guardar presupuesto';

  @override
  String get chartIncome => 'Ingresos';

  @override
  String get chartExpenses => 'Gastos';

  @override
  String get chartNoDataMonth => 'Sin datos este mes';

  @override
  String get chartTotalMonth => 'Total este mes';

  @override
  String get legalTermsSection1Title => 'Aceptación de los Términos';

  @override
  String get legalTermsSection1Body =>
      'Al crear una cuenta en FinanSys, usted acepta quedar vinculado por estos Términos y Condiciones. Si no está de acuerdo con alguna parte de estos términos, no podrá acceder al servicio.';

  @override
  String get legalTermsSection2Title => 'Descripción del Servicio';

  @override
  String get legalTermsSection2Body =>
      'FinanSys es una aplicación de gestión de finanzas personales que permite registrar ingresos, gastos, presupuestos y realizar conversiones de divisas. El servicio se proporciona \"tal como está\" y puede ser modificado o discontinuado en cualquier momento.';

  @override
  String get legalTermsSection3Title => 'Registro y Cuenta de Usuario';

  @override
  String get legalTermsSection3Body =>
      'Para usar FinanSys debe crear una cuenta proporcionando información verídica y actualizada. Usted es responsable de mantener la confidencialidad de su contraseña y de todas las actividades que ocurran bajo su cuenta. Debe notificarnos inmediatamente sobre cualquier uso no autorizado.';

  @override
  String get legalTermsSection4Title => 'Privacidad y Tratamiento de Datos';

  @override
  String get legalTermsSection4Body =>
      'Recopilamos y procesamos sus datos personales de acuerdo con nuestra Política de Privacidad. Sus datos financieros son privados y no serán compartidos con terceros sin su consentimiento explícito, salvo requerimiento legal. Las contraseñas se almacenan cifradas y nunca en texto plano.';

  @override
  String get legalTermsSection5Title => 'Uso Aceptable';

  @override
  String get legalTermsSection5Body =>
      'Usted se compromete a usar FinanSys únicamente para fines legítimos y personales. Está prohibido: intentar acceder a cuentas de otros usuarios, realizar ingeniería inversa del sistema, usar el servicio para actividades ilegales, o intentar comprometer la seguridad de la plataforma.';

  @override
  String get legalTermsSection6Title => 'Limitación de Responsabilidad';

  @override
  String get legalTermsSection6Body =>
      'FinanSys no se responsabiliza por decisiones financieras tomadas con base en la información mostrada en la aplicación. La información de tasas de cambio es referencial y puede variar. No garantizamos la disponibilidad continua del servicio.';

  @override
  String get legalTermsSection7Title => 'Propiedad Intelectual';

  @override
  String get legalTermsSection7Body =>
      'Todo el contenido, diseño, código y funcionalidades de FinanSys son propiedad de sus desarrolladores. No se permite reproducir, distribuir o crear trabajos derivados sin autorización expresa por escrito.';

  @override
  String get legalTermsSection8Title => 'Modificaciones';

  @override
  String get legalTermsSection8Body =>
      'Nos reservamos el derecho de modificar estos términos en cualquier momento. Los cambios entrarán en vigor al ser publicados en la aplicación. El uso continuado del servicio después de los cambios constituye aceptación de los nuevos términos.';

  @override
  String get legalTermsSection9Title => 'Cancelación de Cuenta';

  @override
  String get legalTermsSection9Body =>
      'Puede cancelar su cuenta en cualquier momento. Al hacerlo, todos sus datos serán eliminados permanentemente de nuestros servidores. Nos reservamos el derecho de suspender cuentas que violen estos términos.';

  @override
  String get legalTermsSection10Title => 'Contacto';

  @override
  String get legalTermsSection10Body =>
      'Para preguntas sobre estos Términos y Condiciones puede contactarnos a través de la aplicación. Haremos nuestro mejor esfuerzo para responder en un plazo razonable.';

  @override
  String get legalTermsAppBarTitle => 'Términos y Condiciones';

  @override
  String get legalTermsTitle => 'Términos y Condiciones de Uso';

  @override
  String get legalLastUpdated => 'Última actualización: octubre 2026';

  @override
  String get legalTermsFooterNote =>
      'Al crear una cuenta en FinanSys, confirmas que has leído, entendido y aceptado estos Términos y Condiciones en su totalidad.';

  @override
  String get legalTermsAcceptButton => 'Entendido, acepto los términos';

  @override
  String get legalPrivacySection1Title => 'Responsable del Tratamiento';

  @override
  String get legalPrivacySection1Body =>
      'FinanSys, aplicación de gestión de finanzas personales desarrollada como proyecto académico por estudiantes de la Universidad de Cundinamarca, es responsable del tratamiento de los datos personales recopilados a través de esta plataforma.';

  @override
  String get legalPrivacySection2Title => 'Datos Personales Recopilados';

  @override
  String get legalPrivacySection2Body =>
      'Recopilamos los siguientes datos personales:\n\n• Nombre completo\n• Nombre de usuario (username)\n• Correo electrónico\n• Contraseña (almacenada en formato cifrado con bcrypt)\n• Información financiera: ingresos, gastos, presupuestos y conversiones de divisas registradas por el usuario\n• Datos de actividad: fecha y hora de acceso, dirección IP';

  @override
  String get legalPrivacySection3Title => 'Finalidad del Tratamiento';

  @override
  String get legalPrivacySection3Body =>
      'Los datos personales recopilados se utilizan exclusivamente para:\n\n• Autenticación y acceso seguro a la cuenta\n• Prestación del servicio de gestión financiera personal\n• Personalización de la experiencia del usuario\n• Monitoreo de seguridad y detección de accesos no autorizados\n• Mejora continua del servicio';

  @override
  String get legalPrivacySection4Title => 'Derechos del Titular';

  @override
  String get legalPrivacySection4Body =>
      'Como titular de sus datos personales, usted tiene derecho a:\n\n• Conocer, actualizar y rectificar sus datos\n• Solicitar prueba de la autorización otorgada\n• Ser informado sobre el uso de sus datos\n• Revocar la autorización y solicitar la eliminación de sus datos\n• Acceder gratuitamente a sus datos personales\n\nPuede ejercer estos derechos directamente desde la configuración de su cuenta.';

  @override
  String get legalPrivacySection5Title => 'Seguridad de los Datos';

  @override
  String get legalPrivacySection5Body =>
      'Implementamos medidas técnicas y organizativas para proteger sus datos:\n\n• Contraseñas cifradas con algoritmo bcrypt (salt rounds: 10)\n• Autenticación mediante tokens JWT con expiración de 24 horas\n• Cierre automático de sesión por inactividad\n• Registro de accesos y actividad para auditoría\n• Comunicación cifrada mediante HTTPS';

  @override
  String get legalPrivacySection6Title => 'Compartición de Datos';

  @override
  String get legalPrivacySection6Body =>
      'Sus datos personales NO serán vendidos, arrendados ni compartidos con terceros con fines comerciales. Solo podrán ser divulgados en los siguientes casos:\n\n• Por orden judicial o requerimiento de autoridad competente\n• Cuando sea necesario para proteger los derechos de otros usuarios\n• Con proveedores de servicios técnicos estrictamente necesarios para el funcionamiento de la plataforma, bajo acuerdos de confidencialidad';

  @override
  String get legalPrivacySection7Title => 'Retención de Datos';

  @override
  String get legalPrivacySection7Body =>
      'Sus datos se conservarán mientras mantenga una cuenta activa en FinanSys. Al eliminar su cuenta, todos sus datos personales y financieros serán eliminados permanentemente de nuestros servidores en un plazo máximo de 30 días.';

  @override
  String get legalPrivacySection8Title => 'Cookies y Almacenamiento Local';

  @override
  String get legalPrivacySection8Body =>
      'FinanSys utiliza almacenamiento local del navegador (localStorage) exclusivamente para mantener la sesión del usuario mediante un token de autenticación. No utilizamos cookies de rastreo ni publicidad.';

  @override
  String get legalPrivacySection9Title => 'Transferencias Internacionales';

  @override
  String get legalPrivacySection9Body =>
      'Los datos son almacenados en servidores locales o en servicios de nube con sede en jurisdicciones que cuentan con estándares adecuados de protección de datos. No realizamos transferencias internacionales de datos sin las garantías adecuadas.';

  @override
  String get legalPrivacySection10Title => 'Cambios en la Política';

  @override
  String get legalPrivacySection10Body =>
      'Nos reservamos el derecho de actualizar esta política. Los cambios serán notificados a través de la aplicación. El uso continuado del servicio tras la notificación implica aceptación de la nueva política.';

  @override
  String get legalPrivacyAppBarTitle => 'Política de Tratamiento de Datos';

  @override
  String get legalPrivacyTitle => 'Política de Tratamiento de Datos Personales';

  @override
  String get legalPrivacyIntro =>
      'De conformidad con la Ley 1581 de 2012 y el Decreto 1377 de 2013 de la República de Colombia, FinanSys informa su política de tratamiento de datos personales.';

  @override
  String get legalPrivacyFooterNote =>
      'Al usar FinanSys usted autoriza el tratamiento de sus datos personales de acuerdo con esta política, en cumplimiento de la Ley 1581 de 2012.';

  @override
  String get legalPrivacyAcceptButton => 'Entendido';

  @override
  String errValidationMissingFields(String fields) {
    return 'Faltan datos requeridos: $fields';
  }

  @override
  String get errValidationUsernameFormat =>
      'Usuario inválido: solo letras, números y _ (3-20 caracteres)';

  @override
  String errValidationPasswordMin(int min) {
    return 'La contraseña debe tener mínimo $min caracteres';
  }

  @override
  String get errValidationNothingToUpdate =>
      'Debes enviar al menos un campo para actualizar';

  @override
  String get errValidationInvalidTheme => 'Tema inválido';

  @override
  String get errValidationInvalidFormat => 'Formato inválido: usa PDF o Excel';

  @override
  String get errValidationInvalidMonth => 'Mes inválido (1 a 12)';

  @override
  String get errValidationInvalidYear => 'Año inválido';

  @override
  String get errValidationInvalidUid => 'Identificador de usuario inválido';

  @override
  String get errAuthUserNotFound => 'Usuario no encontrado';

  @override
  String get errAuthWrongPassword => 'Contraseña incorrecta';

  @override
  String get errAuthTokenMissing => 'No has iniciado sesión';

  @override
  String get errAuthTokenInvalid =>
      'Tu sesión no es válida. Inicia sesión de nuevo.';

  @override
  String get errSesionCerrada =>
      'Tu sesión ya no es válida. Inicia sesión de nuevo.';

  @override
  String get errSesionReemplazada =>
      'Tu cuenta se abrió en otra ventana o dispositivo, por eso se cerró esta sesión.';

  @override
  String get errAuthSessionCheckFailed => 'No se pudo verificar la sesión';

  @override
  String get errAuthForbiddenAdminOnly => 'Acceso solo para administradores';

  @override
  String get errAuthAccountDisabled => 'Cuenta desactivada';

  @override
  String get errAuthResetLinkInvalid => 'El enlace es inválido o ha expirado';

  @override
  String get errAuthGoogleTokenMissing => 'Falta el token de Google';

  @override
  String get errAuthGoogleTokenInvalid => 'Token de Google inválido o vencido';

  @override
  String get errAuthGoogleEmailUnverified =>
      'Tu correo de Google no está verificado';

  @override
  String get errAuthGoogleNotConfigured =>
      'El inicio con Google no está configurado en el servidor';

  @override
  String get errConflictEmailTaken => 'El correo ya está registrado';

  @override
  String get errConflictUsernameTaken => 'El username ya está en uso';

  @override
  String get errNotFoundExpense => 'Gasto no encontrado';

  @override
  String get errNotFoundRoute => 'Recurso no encontrado';

  @override
  String errRateLimitDaily(int limit) {
    return 'Límite diario alcanzado ($limit solicitudes). Intenta mañana.';
  }

  @override
  String get errExternalRateFetchFailed =>
      'Error consultando la tasa de cambio';

  @override
  String get errExternalConvertFailed => 'Error convirtiendo la moneda';

  @override
  String get errInternalError => 'Error interno del servidor';

  @override
  String get errNetwork =>
      'Sin conexión. Verifica que el servidor esté corriendo.';

  @override
  String get errUnknown => 'Ocurrió un error inesperado';

  @override
  String get authUsernameAvailable => 'Usuario disponible';
}
