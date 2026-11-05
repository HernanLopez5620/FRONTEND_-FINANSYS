import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @commonCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get commonEdit;

  /// No description provided for @commonAccept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get commonAccept;

  /// No description provided for @commonClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get commonClose;

  /// No description provided for @commonRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get commonRetry;

  /// No description provided for @commonContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get commonContinue;

  /// No description provided for @commonSearch.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get commonSearch;

  /// No description provided for @commonLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get commonLoading;

  /// No description provided for @commonYes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'FinanSys'**
  String get appTitle;

  /// No description provided for @dashRegister.
  ///
  /// In es, this message translates to:
  /// **'Registrar'**
  String get dashRegister;

  /// No description provided for @dashMonthlyComparison.
  ///
  /// In es, this message translates to:
  /// **'Comparación mensual'**
  String get dashMonthlyComparison;

  /// No description provided for @dashExpensesByCategory.
  ///
  /// In es, this message translates to:
  /// **'Gastos por categoría'**
  String get dashExpensesByCategory;

  /// No description provided for @dashLatestMovements.
  ///
  /// In es, this message translates to:
  /// **'Últimos movimientos'**
  String get dashLatestMovements;

  /// No description provided for @dashSeeAll.
  ///
  /// In es, this message translates to:
  /// **'Ver todos'**
  String get dashSeeAll;

  /// No description provided for @dashNoMovementsMonth.
  ///
  /// In es, this message translates to:
  /// **'Sin movimientos este mes'**
  String get dashNoMovementsMonth;

  /// No description provided for @dashTapPlusFirst.
  ///
  /// In es, this message translates to:
  /// **'Toca + para registrar el primero'**
  String get dashTapPlusFirst;

  /// No description provided for @gastosFilterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get gastosFilterAll;

  /// No description provided for @gastosFilterExpenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get gastosFilterExpenses;

  /// No description provided for @gastosFilterIncome.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get gastosFilterIncome;

  /// No description provided for @gastosEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin movimientos'**
  String get gastosEmptyTitle;

  /// No description provided for @gastosEmptySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Toca + para registrar uno'**
  String get gastosEmptySubtitle;

  /// No description provided for @gastosDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar movimiento'**
  String get gastosDeleteTitle;

  /// No description provided for @gastosDeleteConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres eliminar \"{name}\"?'**
  String gastosDeleteConfirm(String name);

  /// No description provided for @gastosThisMovement.
  ///
  /// In es, this message translates to:
  /// **'este movimiento'**
  String get gastosThisMovement;

  /// No description provided for @catEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin categorías'**
  String get catEmptyTitle;

  /// No description provided for @catEmptySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Crea tu primera categoría'**
  String get catEmptySubtitle;

  /// No description provided for @catCreate.
  ///
  /// In es, this message translates to:
  /// **'Crear categoría'**
  String get catCreate;

  /// No description provided for @budgetEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin presupuestos'**
  String get budgetEmptyTitle;

  /// No description provided for @budgetEmptySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Define límites por categoría'**
  String get budgetEmptySubtitle;

  /// No description provided for @budgetCreate.
  ///
  /// In es, this message translates to:
  /// **'Crear presupuesto'**
  String get budgetCreate;

  /// No description provided for @budgetMonthTitle.
  ///
  /// In es, this message translates to:
  /// **'Presupuesto del mes'**
  String get budgetMonthTitle;

  /// No description provided for @headerViewProfile.
  ///
  /// In es, this message translates to:
  /// **'Ver perfil'**
  String get headerViewProfile;

  /// No description provided for @headerAdmin.
  ///
  /// In es, this message translates to:
  /// **'Administración'**
  String get headerAdmin;

  /// No description provided for @headerLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get headerLogout;

  /// No description provided for @headerLogoutConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro que deseas cerrar sesión?'**
  String get headerLogoutConfirm;

  /// No description provided for @headerDebtWarning.
  ///
  /// In es, this message translates to:
  /// **'Tienes deudas este mes'**
  String get headerDebtWarning;

  /// No description provided for @headerBalanceAvailable.
  ///
  /// In es, this message translates to:
  /// **'Balance disponible'**
  String get headerBalanceAvailable;

  /// No description provided for @headerIncome.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get headerIncome;

  /// No description provided for @headerExpenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get headerExpenses;

  /// No description provided for @headerSavings.
  ///
  /// In es, this message translates to:
  /// **'Ahorro'**
  String get headerSavings;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navMovements.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get navMovements;

  /// No description provided for @navReports.
  ///
  /// In es, this message translates to:
  /// **'Reportes'**
  String get navReports;

  /// No description provided for @navCategories.
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get navCategories;

  /// No description provided for @navBudgets.
  ///
  /// In es, this message translates to:
  /// **'Presupuestos'**
  String get navBudgets;

  /// No description provided for @navCurrencies.
  ///
  /// In es, this message translates to:
  /// **'Divisas'**
  String get navCurrencies;

  /// No description provided for @authLoginTab.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get authLoginTab;

  /// No description provided for @authRegisterTab.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get authRegisterTab;

  /// No description provided for @authTagline.
  ///
  /// In es, this message translates to:
  /// **'Tus finanzas bajo control'**
  String get authTagline;

  /// No description provided for @authLoginError.
  ///
  /// In es, this message translates to:
  /// **'Error al iniciar sesión'**
  String get authLoginError;

  /// No description provided for @authEmailOrUser.
  ///
  /// In es, this message translates to:
  /// **'Correo o usuario'**
  String get authEmailOrUser;

  /// No description provided for @authEmailOrUserRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu correo o usuario'**
  String get authEmailOrUserRequired;

  /// No description provided for @authPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get authPassword;

  /// No description provided for @authPasswordRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu contraseña'**
  String get authPasswordRequired;

  /// No description provided for @authLoginButton.
  ///
  /// In es, this message translates to:
  /// **'Ingresar'**
  String get authLoginButton;

  /// No description provided for @authUsernameHint.
  ///
  /// In es, this message translates to:
  /// **'Solo letras, números y _ (3-20 caracteres)'**
  String get authUsernameHint;

  /// No description provided for @authMustAcceptTerms.
  ///
  /// In es, this message translates to:
  /// **'Debes aceptar los Términos y la Política de Datos'**
  String get authMustAcceptTerms;

  /// No description provided for @authUsernameUnavailable.
  ///
  /// In es, this message translates to:
  /// **'El username no está disponible'**
  String get authUsernameUnavailable;

  /// No description provided for @authRegisterError.
  ///
  /// In es, this message translates to:
  /// **'Error al registrarse'**
  String get authRegisterError;

  /// No description provided for @authFullName.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get authFullName;

  /// No description provided for @authNameRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu nombre'**
  String get authNameRequired;

  /// No description provided for @authUsernameLabel.
  ///
  /// In es, this message translates to:
  /// **'Usuario (ej: JuanCa123)'**
  String get authUsernameLabel;

  /// No description provided for @authUsernameRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un usuario'**
  String get authUsernameRequired;

  /// No description provided for @authEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get authEmail;

  /// No description provided for @authEmailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Correo inválido'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordMin.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get authPasswordMin;

  /// No description provided for @authConfirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get authConfirmPassword;

  /// No description provided for @authPasswordsMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get authPasswordsMismatch;

  /// No description provided for @authAcceptPrefix.
  ///
  /// In es, this message translates to:
  /// **'He leído y acepto los '**
  String get authAcceptPrefix;

  /// No description provided for @authTermsLink.
  ///
  /// In es, this message translates to:
  /// **'Términos y Condiciones'**
  String get authTermsLink;

  /// No description provided for @authAuthorizePrefix.
  ///
  /// In es, this message translates to:
  /// **'Autorizo el '**
  String get authAuthorizePrefix;

  /// No description provided for @authPersonalDataLink.
  ///
  /// In es, this message translates to:
  /// **'Tratamiento de mis Datos Personales'**
  String get authPersonalDataLink;

  /// No description provided for @authRegisterButton.
  ///
  /// In es, this message translates to:
  /// **'Registrarme'**
  String get authRegisterButton;

  /// No description provided for @authGoogleLoginError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar sesión con Google'**
  String get authGoogleLoginError;

  /// No description provided for @authGoogleLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el inicio con Google'**
  String get authGoogleLoadError;

  /// No description provided for @authOr.
  ///
  /// In es, this message translates to:
  /// **'o'**
  String get authOr;

  /// No description provided for @authGoogleTermsNotice.
  ///
  /// In es, this message translates to:
  /// **'Al continuar con Google aceptas los Términos y la Política de datos de FinanSys.'**
  String get authGoogleTermsNotice;

  /// No description provided for @sessionReplacedNotice.
  ///
  /// In es, this message translates to:
  /// **'Tu cuenta se abrió en otra ventana o dispositivo, por eso se cerró esta sesión.'**
  String get sessionReplacedNotice;

  /// No description provided for @sessionInvalidNotice.
  ///
  /// In es, this message translates to:
  /// **'Tu sesión ya no es válida. Inicia sesión de nuevo.'**
  String get sessionInvalidNotice;

  /// No description provided for @sessionStillThereTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Sigues ahí?'**
  String get sessionStillThereTitle;

  /// No description provided for @sessionWillCloseIn.
  ///
  /// In es, this message translates to:
  /// **'Tu sesión se cerrará por inactividad en:'**
  String get sessionWillCloseIn;

  /// No description provided for @sessionContinueButton.
  ///
  /// In es, this message translates to:
  /// **'Continuar sesión'**
  String get sessionContinueButton;

  /// No description provided for @sessionClosedTitle.
  ///
  /// In es, this message translates to:
  /// **'Sesión cerrada'**
  String get sessionClosedTitle;

  /// No description provided for @sessionClosedInactivity.
  ///
  /// In es, this message translates to:
  /// **'Tu sesión fue cerrada por inactividad.'**
  String get sessionClosedInactivity;

  /// No description provided for @sessionCanLoginIn.
  ///
  /// In es, this message translates to:
  /// **'Podrás ingresar en:'**
  String get sessionCanLoginIn;

  /// No description provided for @sessionSecondsShort.
  ///
  /// In es, this message translates to:
  /// **'{segundos}s'**
  String sessionSecondsShort(int segundos);

  /// No description provided for @sessionWaitSecurityNotice.
  ///
  /// In es, this message translates to:
  /// **'Por tu seguridad debes esperar antes de volver a iniciar sesión.'**
  String get sessionWaitSecurityNotice;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get profileTitle;

  /// No description provided for @profileUpdated.
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado'**
  String get profileUpdated;

  /// No description provided for @profileUpdateError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo actualizar el perfil'**
  String get profileUpdateError;

  /// No description provided for @profileAccountActive.
  ///
  /// In es, this message translates to:
  /// **'✅ Cuenta activa'**
  String get profileAccountActive;

  /// No description provided for @profileAccountInactive.
  ///
  /// In es, this message translates to:
  /// **'❌ Cuenta inactiva'**
  String get profileAccountInactive;

  /// No description provided for @profileMemberSince.
  ///
  /// In es, this message translates to:
  /// **'Miembro desde {fecha}'**
  String profileMemberSince(String fecha);

  /// No description provided for @profilePersonalData.
  ///
  /// In es, this message translates to:
  /// **'Datos personales'**
  String get profilePersonalData;

  /// No description provided for @profileUsername.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get profileUsername;

  /// No description provided for @profileUsernameRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un nombre de usuario'**
  String get profileUsernameRequired;

  /// No description provided for @profileChangePasswordOptional.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña (opcional)'**
  String get profileChangePasswordOptional;

  /// No description provided for @profileNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get profileNewPassword;

  /// No description provided for @profileSaveChanges.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get profileSaveChanges;

  /// No description provided for @profileAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get profileAppearance;

  /// No description provided for @profileThemeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get profileThemeLight;

  /// No description provided for @profileThemeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get profileThemeDark;

  /// No description provided for @profileThemeGamer.
  ///
  /// In es, this message translates to:
  /// **'Gamer'**
  String get profileThemeGamer;

  /// No description provided for @profileMyData.
  ///
  /// In es, this message translates to:
  /// **'Mis datos'**
  String get profileMyData;

  /// No description provided for @profileBackupDescription.
  ///
  /// In es, this message translates to:
  /// **'Descarga una copia de tus datos (perfil, categorías, movimientos, presupuestos y compras en el extranjero) en un archivo JSON. No incluye contraseñas.'**
  String get profileBackupDescription;

  /// No description provided for @profileBackupDownloaded.
  ///
  /// In es, this message translates to:
  /// **'Copia de seguridad descargada'**
  String get profileBackupDownloaded;

  /// No description provided for @profileBackupError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo descargar la copia'**
  String get profileBackupError;

  /// No description provided for @profileBackupGenerating.
  ///
  /// In es, this message translates to:
  /// **'Generando...'**
  String get profileBackupGenerating;

  /// No description provided for @profileBackupDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar mis datos'**
  String get profileBackupDownload;

  /// No description provided for @profileLegalInfo.
  ///
  /// In es, this message translates to:
  /// **'Información legal'**
  String get profileLegalInfo;

  /// No description provided for @profileDataPolicy.
  ///
  /// In es, this message translates to:
  /// **'Política de tratamiento de datos'**
  String get profileDataPolicy;

  /// No description provided for @profileLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get profileLanguage;

  /// No description provided for @adminTitle.
  ///
  /// In es, this message translates to:
  /// **'Administración'**
  String get adminTitle;

  /// No description provided for @adminRefreshTooltip.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get adminRefreshTooltip;

  /// No description provided for @adminTabSummary.
  ///
  /// In es, this message translates to:
  /// **'Resumen'**
  String get adminTabSummary;

  /// No description provided for @adminTabUsers.
  ///
  /// In es, this message translates to:
  /// **'Usuarios'**
  String get adminTabUsers;

  /// No description provided for @adminTabActivity.
  ///
  /// In es, this message translates to:
  /// **'Actividad'**
  String get adminTabActivity;

  /// No description provided for @adminSummaryLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el resumen'**
  String get adminSummaryLoadError;

  /// No description provided for @adminStatUsers.
  ///
  /// In es, this message translates to:
  /// **'Usuarios registrados'**
  String get adminStatUsers;

  /// No description provided for @adminStatSessions.
  ///
  /// In es, this message translates to:
  /// **'Sesiones abiertas'**
  String get adminStatSessions;

  /// No description provided for @adminStatNew7d.
  ///
  /// In es, this message translates to:
  /// **'Nuevos (7 días)'**
  String get adminStatNew7d;

  /// No description provided for @adminStatActive24h.
  ///
  /// In es, this message translates to:
  /// **'Activos (24 h)'**
  String get adminStatActive24h;

  /// No description provided for @adminStatRequests24h.
  ///
  /// In es, this message translates to:
  /// **'Peticiones (24 h)'**
  String get adminStatRequests24h;

  /// No description provided for @adminStatErrors24h.
  ///
  /// In es, this message translates to:
  /// **'Errores (24 h)'**
  String get adminStatErrors24h;

  /// No description provided for @adminSecurityNote.
  ///
  /// In es, this message translates to:
  /// **'Por seguridad, este panel nunca muestra contraseñas.'**
  String get adminSecurityNote;

  /// No description provided for @adminNoUsersFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron usuarios'**
  String get adminNoUsersFound;

  /// No description provided for @adminSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar por nombre, usuario o correo'**
  String get adminSearchHint;

  /// No description provided for @adminUserCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 usuario} other{{count} usuarios}}'**
  String adminUserCount(int count);

  /// No description provided for @adminAdminBadge.
  ///
  /// In es, this message translates to:
  /// **'Admin'**
  String get adminAdminBadge;

  /// No description provided for @adminOnline.
  ///
  /// In es, this message translates to:
  /// **'En línea'**
  String get adminOnline;

  /// No description provided for @adminActionsUnit.
  ///
  /// In es, this message translates to:
  /// **'acciones'**
  String get adminActionsUnit;

  /// No description provided for @adminNoActivityYet.
  ///
  /// In es, this message translates to:
  /// **'Sin actividad'**
  String get adminNoActivityYet;

  /// No description provided for @adminAgoNow.
  ///
  /// In es, this message translates to:
  /// **'Hace un momento'**
  String get adminAgoNow;

  /// No description provided for @adminAgoMinutes.
  ///
  /// In es, this message translates to:
  /// **'Hace {n} min'**
  String adminAgoMinutes(int n);

  /// No description provided for @adminAgoHours.
  ///
  /// In es, this message translates to:
  /// **'Hace {n} h'**
  String adminAgoHours(int n);

  /// No description provided for @adminAgoDays.
  ///
  /// In es, this message translates to:
  /// **'Hace {n} d'**
  String adminAgoDays(int n);

  /// No description provided for @adminDetailUser.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get adminDetailUser;

  /// No description provided for @adminDetailEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get adminDetailEmail;

  /// No description provided for @adminDetailRole.
  ///
  /// In es, this message translates to:
  /// **'Rol'**
  String get adminDetailRole;

  /// No description provided for @adminRoleAdmin.
  ///
  /// In es, this message translates to:
  /// **'Administrador'**
  String get adminRoleAdmin;

  /// No description provided for @adminRoleUser.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get adminRoleUser;

  /// No description provided for @adminDetailRegistered.
  ///
  /// In es, this message translates to:
  /// **'Registrado'**
  String get adminDetailRegistered;

  /// No description provided for @adminDetailStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get adminDetailStatus;

  /// No description provided for @adminDetailSession.
  ///
  /// In es, this message translates to:
  /// **'Sesión'**
  String get adminDetailSession;

  /// No description provided for @adminSessionOpen.
  ///
  /// In es, this message translates to:
  /// **'Abierta'**
  String get adminSessionOpen;

  /// No description provided for @adminSessionClosed.
  ///
  /// In es, this message translates to:
  /// **'Cerrada'**
  String get adminSessionClosed;

  /// No description provided for @adminDetailActions.
  ///
  /// In es, this message translates to:
  /// **'Acciones'**
  String get adminDetailActions;

  /// No description provided for @adminActionsRegistered.
  ///
  /// In es, this message translates to:
  /// **'{count} registradas'**
  String adminActionsRegistered(int count);

  /// No description provided for @adminFilterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get adminFilterAll;

  /// No description provided for @adminFilterOnlyErrors.
  ///
  /// In es, this message translates to:
  /// **'Solo errores'**
  String get adminFilterOnlyErrors;

  /// No description provided for @adminNoActivityRecorded.
  ///
  /// In es, this message translates to:
  /// **'Sin actividad registrada'**
  String get adminNoActivityRecorded;

  /// No description provided for @adminLoadMore.
  ///
  /// In es, this message translates to:
  /// **'Cargar más ({shown} de {total})'**
  String adminLoadMore(String shown, String total);

  /// No description provided for @adminTotalRecords.
  ///
  /// In es, this message translates to:
  /// **'{total} registros en total'**
  String adminTotalRecords(String total);

  /// No description provided for @adminLogAnonymous.
  ///
  /// In es, this message translates to:
  /// **'Sin sesión (anónimo)'**
  String get adminLogAnonymous;

  /// No description provided for @logLoginFailed.
  ///
  /// In es, this message translates to:
  /// **'Intento de inicio de sesión fallido'**
  String get logLoginFailed;

  /// No description provided for @logLoginOk.
  ///
  /// In es, this message translates to:
  /// **'Inició sesión'**
  String get logLoginOk;

  /// No description provided for @logRegisterFailed.
  ///
  /// In es, this message translates to:
  /// **'Registro fallido'**
  String get logRegisterFailed;

  /// No description provided for @logRegisterOk.
  ///
  /// In es, this message translates to:
  /// **'Creó su cuenta'**
  String get logRegisterOk;

  /// No description provided for @logLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerró sesión'**
  String get logLogout;

  /// No description provided for @logProfileView.
  ///
  /// In es, this message translates to:
  /// **'Consultó su perfil'**
  String get logProfileView;

  /// No description provided for @logProfileUpdate.
  ///
  /// In es, this message translates to:
  /// **'Actualizó su perfil'**
  String get logProfileUpdate;

  /// No description provided for @logThemeChange.
  ///
  /// In es, this message translates to:
  /// **'Cambió el tema'**
  String get logThemeChange;

  /// No description provided for @logCheckUsername.
  ///
  /// In es, this message translates to:
  /// **'Verificó un nombre de usuario'**
  String get logCheckUsername;

  /// No description provided for @logForgotPassword.
  ///
  /// In es, this message translates to:
  /// **'Pidió restablecer su contraseña'**
  String get logForgotPassword;

  /// No description provided for @logResetPassword.
  ///
  /// In es, this message translates to:
  /// **'Restableció su contraseña'**
  String get logResetPassword;

  /// No description provided for @logUsersList.
  ///
  /// In es, this message translates to:
  /// **'Consultó la lista de usuarios'**
  String get logUsersList;

  /// No description provided for @logAdminPanel.
  ///
  /// In es, this message translates to:
  /// **'Consultó el panel de administración'**
  String get logAdminPanel;

  /// No description provided for @logMovementCreate.
  ///
  /// In es, this message translates to:
  /// **'Registró un movimiento'**
  String get logMovementCreate;

  /// No description provided for @logMovementEdit.
  ///
  /// In es, this message translates to:
  /// **'Editó un movimiento'**
  String get logMovementEdit;

  /// No description provided for @logMovementDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminó un movimiento'**
  String get logMovementDelete;

  /// No description provided for @logReportPdf.
  ///
  /// In es, this message translates to:
  /// **'Descargó un reporte en PDF'**
  String get logReportPdf;

  /// No description provided for @logReportExcel.
  ///
  /// In es, this message translates to:
  /// **'Descargó un reporte en Excel'**
  String get logReportExcel;

  /// No description provided for @logReportDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargó un reporte'**
  String get logReportDownload;

  /// No description provided for @logReportsView.
  ///
  /// In es, this message translates to:
  /// **'Consultó reportes'**
  String get logReportsView;

  /// No description provided for @logMovementsView.
  ///
  /// In es, this message translates to:
  /// **'Consultó sus movimientos'**
  String get logMovementsView;

  /// No description provided for @logCategoryCreate.
  ///
  /// In es, this message translates to:
  /// **'Creó una categoría'**
  String get logCategoryCreate;

  /// No description provided for @logCategoryEdit.
  ///
  /// In es, this message translates to:
  /// **'Editó una categoría'**
  String get logCategoryEdit;

  /// No description provided for @logCategoryDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminó una categoría'**
  String get logCategoryDelete;

  /// No description provided for @logCategoriesView.
  ///
  /// In es, this message translates to:
  /// **'Consultó sus categorías'**
  String get logCategoriesView;

  /// No description provided for @logBudgetSave.
  ///
  /// In es, this message translates to:
  /// **'Guardó un presupuesto'**
  String get logBudgetSave;

  /// No description provided for @logBudgetEdit.
  ///
  /// In es, this message translates to:
  /// **'Editó un presupuesto'**
  String get logBudgetEdit;

  /// No description provided for @logBudgetDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminó un presupuesto'**
  String get logBudgetDelete;

  /// No description provided for @logBudgetsView.
  ///
  /// In es, this message translates to:
  /// **'Consultó sus presupuestos'**
  String get logBudgetsView;

  /// No description provided for @logForeignSave.
  ///
  /// In es, this message translates to:
  /// **'Guardó una compra extranjera'**
  String get logForeignSave;

  /// No description provided for @logForeignDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminó una compra extranjera'**
  String get logForeignDelete;

  /// No description provided for @logForeignView.
  ///
  /// In es, this message translates to:
  /// **'Consultó sus compras extranjeras'**
  String get logForeignView;

  /// No description provided for @logRatesView.
  ///
  /// In es, this message translates to:
  /// **'Consultó tasas de cambio'**
  String get logRatesView;

  /// No description provided for @logWithError.
  ///
  /// In es, this message translates to:
  /// **'{base} (con error)'**
  String logWithError(String base);

  /// No description provided for @divisasFillNameFirst.
  ///
  /// In es, this message translates to:
  /// **'Completa el nombre y realiza una conversión primero'**
  String get divisasFillNameFirst;

  /// No description provided for @divisasSaved.
  ///
  /// In es, this message translates to:
  /// **'✅ Compra guardada'**
  String get divisasSaved;

  /// No description provided for @divisasSaveError.
  ///
  /// In es, this message translates to:
  /// **'❌ Error al guardar'**
  String get divisasSaveError;

  /// No description provided for @divisasCalcTitle.
  ///
  /// In es, this message translates to:
  /// **'Calculadora de divisas'**
  String get divisasCalcTitle;

  /// No description provided for @divisasAutoUpdate.
  ///
  /// In es, this message translates to:
  /// **'El resultado se actualiza automáticamente'**
  String get divisasAutoUpdate;

  /// No description provided for @divisasFrom.
  ///
  /// In es, this message translates to:
  /// **'De'**
  String get divisasFrom;

  /// No description provided for @divisasAmount.
  ///
  /// In es, this message translates to:
  /// **'Monto'**
  String get divisasAmount;

  /// No description provided for @divisasTo.
  ///
  /// In es, this message translates to:
  /// **'A'**
  String get divisasTo;

  /// No description provided for @divisasPurchaseNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la compra (ej: Camiseta Nike)'**
  String get divisasPurchaseNameLabel;

  /// No description provided for @divisasSavePurchase.
  ///
  /// In es, this message translates to:
  /// **'Guardar compra'**
  String get divisasSavePurchase;

  /// No description provided for @divisasSavedTitle.
  ///
  /// In es, this message translates to:
  /// **'Compras guardadas'**
  String get divisasSavedTitle;

  /// No description provided for @divisasEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin compras guardadas'**
  String get divisasEmpty;

  /// No description provided for @divisasDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar compra'**
  String get divisasDeleteTitle;

  /// No description provided for @divisasDeleteConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres eliminar \"{nombre}\"?'**
  String divisasDeleteConfirm(String nombre);

  /// No description provided for @reportTabByCategory.
  ///
  /// In es, this message translates to:
  /// **'Por categoría'**
  String get reportTabByCategory;

  /// No description provided for @reportTabMonthly.
  ///
  /// In es, this message translates to:
  /// **'Mensual'**
  String get reportTabMonthly;

  /// No description provided for @reportDistribution.
  ///
  /// In es, this message translates to:
  /// **'Distribución de gastos'**
  String get reportDistribution;

  /// No description provided for @reportNoDataMonth.
  ///
  /// In es, this message translates to:
  /// **'Sin datos este mes'**
  String get reportNoDataMonth;

  /// No description provided for @reportDetailByCategory.
  ///
  /// In es, this message translates to:
  /// **'Detalle por categoría'**
  String get reportDetailByCategory;

  /// No description provided for @reportIncomeVsExpenses.
  ///
  /// In es, this message translates to:
  /// **'Ingresos vs. Gastos'**
  String get reportIncomeVsExpenses;

  /// No description provided for @reportNoData.
  ///
  /// In es, this message translates to:
  /// **'Sin datos'**
  String get reportNoData;

  /// No description provided for @reportMonthlyComparison.
  ///
  /// In es, this message translates to:
  /// **'Comparativa mensual'**
  String get reportMonthlyComparison;

  /// No description provided for @reportIncome.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get reportIncome;

  /// No description provided for @reportExpenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get reportExpenses;

  /// No description provided for @reportBalance.
  ///
  /// In es, this message translates to:
  /// **'Balance'**
  String get reportBalance;

  /// No description provided for @reportDownloaded.
  ///
  /// In es, this message translates to:
  /// **'Reporte descargado ({formato})'**
  String reportDownloaded(String formato);

  /// No description provided for @reportExportFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo exportar el reporte'**
  String get reportExportFailed;

  /// No description provided for @reportExportTooltip.
  ///
  /// In es, this message translates to:
  /// **'Exportar reporte'**
  String get reportExportTooltip;

  /// No description provided for @reportOfMonth.
  ///
  /// In es, this message translates to:
  /// **'Reporte de {mes}'**
  String reportOfMonth(String mes);

  /// No description provided for @reportDownloadPdf.
  ///
  /// In es, this message translates to:
  /// **'Descargar PDF'**
  String get reportDownloadPdf;

  /// No description provided for @reportDownloadExcel.
  ///
  /// In es, this message translates to:
  /// **'Descargar Excel'**
  String get reportDownloadExcel;

  /// No description provided for @reportFilePrefix.
  ///
  /// In es, this message translates to:
  /// **'FinanSys_reporte'**
  String get reportFilePrefix;

  /// No description provided for @gastoFormSelectCategory.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una categoría'**
  String get gastoFormSelectCategory;

  /// No description provided for @gastoFormEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar movimiento'**
  String get gastoFormEdit;

  /// No description provided for @gastoFormNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevo movimiento'**
  String get gastoFormNew;

  /// No description provided for @gastoFormTabExpense.
  ///
  /// In es, this message translates to:
  /// **'Gasto'**
  String get gastoFormTabExpense;

  /// No description provided for @gastoFormTabIncome.
  ///
  /// In es, this message translates to:
  /// **'Ingreso'**
  String get gastoFormTabIncome;

  /// No description provided for @gastoFormAmount.
  ///
  /// In es, this message translates to:
  /// **'Monto'**
  String get gastoFormAmount;

  /// No description provided for @gastoFormDescription.
  ///
  /// In es, this message translates to:
  /// **'Descripción (opcional)'**
  String get gastoFormDescription;

  /// No description provided for @gastoFormCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get gastoFormCategory;

  /// No description provided for @gastoFormNoCategories.
  ///
  /// In es, this message translates to:
  /// **'Sin categorías para este tipo'**
  String get gastoFormNoCategories;

  /// No description provided for @gastoFormUpdate.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get gastoFormUpdate;

  /// No description provided for @catFormTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva categoría'**
  String get catFormTitle;

  /// No description provided for @catFormName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get catFormName;

  /// No description provided for @catFormType.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get catFormType;

  /// No description provided for @catFormTypeExpense.
  ///
  /// In es, this message translates to:
  /// **'gasto'**
  String get catFormTypeExpense;

  /// No description provided for @catFormTypeIncome.
  ///
  /// In es, this message translates to:
  /// **'ingreso'**
  String get catFormTypeIncome;

  /// No description provided for @catFormIcon.
  ///
  /// In es, this message translates to:
  /// **'Ícono'**
  String get catFormIcon;

  /// No description provided for @catFormColor.
  ///
  /// In es, this message translates to:
  /// **'Color'**
  String get catFormColor;

  /// No description provided for @catFormCreate.
  ///
  /// In es, this message translates to:
  /// **'Crear categoría'**
  String get catFormCreate;

  /// No description provided for @budgetFormTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevo presupuesto'**
  String get budgetFormTitle;

  /// No description provided for @budgetFormCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get budgetFormCategory;

  /// No description provided for @budgetFormLimit.
  ///
  /// In es, this message translates to:
  /// **'Monto límite'**
  String get budgetFormLimit;

  /// No description provided for @budgetFormSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar presupuesto'**
  String get budgetFormSave;

  /// No description provided for @chartIncome.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get chartIncome;

  /// No description provided for @chartExpenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get chartExpenses;

  /// No description provided for @chartNoDataMonth.
  ///
  /// In es, this message translates to:
  /// **'Sin datos este mes'**
  String get chartNoDataMonth;

  /// No description provided for @chartTotalMonth.
  ///
  /// In es, this message translates to:
  /// **'Total este mes'**
  String get chartTotalMonth;

  /// No description provided for @legalTermsSection1Title.
  ///
  /// In es, this message translates to:
  /// **'Aceptación de los Términos'**
  String get legalTermsSection1Title;

  /// No description provided for @legalTermsSection1Body.
  ///
  /// In es, this message translates to:
  /// **'Al crear una cuenta en FinanSys, usted acepta quedar vinculado por estos Términos y Condiciones. Si no está de acuerdo con alguna parte de estos términos, no podrá acceder al servicio.'**
  String get legalTermsSection1Body;

  /// No description provided for @legalTermsSection2Title.
  ///
  /// In es, this message translates to:
  /// **'Descripción del Servicio'**
  String get legalTermsSection2Title;

  /// No description provided for @legalTermsSection2Body.
  ///
  /// In es, this message translates to:
  /// **'FinanSys es una aplicación de gestión de finanzas personales que permite registrar ingresos, gastos, presupuestos y realizar conversiones de divisas. El servicio se proporciona \"tal como está\" y puede ser modificado o discontinuado en cualquier momento.'**
  String get legalTermsSection2Body;

  /// No description provided for @legalTermsSection3Title.
  ///
  /// In es, this message translates to:
  /// **'Registro y Cuenta de Usuario'**
  String get legalTermsSection3Title;

  /// No description provided for @legalTermsSection3Body.
  ///
  /// In es, this message translates to:
  /// **'Para usar FinanSys debe crear una cuenta proporcionando información verídica y actualizada. Usted es responsable de mantener la confidencialidad de su contraseña y de todas las actividades que ocurran bajo su cuenta. Debe notificarnos inmediatamente sobre cualquier uso no autorizado.'**
  String get legalTermsSection3Body;

  /// No description provided for @legalTermsSection4Title.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y Tratamiento de Datos'**
  String get legalTermsSection4Title;

  /// No description provided for @legalTermsSection4Body.
  ///
  /// In es, this message translates to:
  /// **'Recopilamos y procesamos sus datos personales de acuerdo con nuestra Política de Privacidad. Sus datos financieros son privados y no serán compartidos con terceros sin su consentimiento explícito, salvo requerimiento legal. Las contraseñas se almacenan cifradas y nunca en texto plano.'**
  String get legalTermsSection4Body;

  /// No description provided for @legalTermsSection5Title.
  ///
  /// In es, this message translates to:
  /// **'Uso Aceptable'**
  String get legalTermsSection5Title;

  /// No description provided for @legalTermsSection5Body.
  ///
  /// In es, this message translates to:
  /// **'Usted se compromete a usar FinanSys únicamente para fines legítimos y personales. Está prohibido: intentar acceder a cuentas de otros usuarios, realizar ingeniería inversa del sistema, usar el servicio para actividades ilegales, o intentar comprometer la seguridad de la plataforma.'**
  String get legalTermsSection5Body;

  /// No description provided for @legalTermsSection6Title.
  ///
  /// In es, this message translates to:
  /// **'Limitación de Responsabilidad'**
  String get legalTermsSection6Title;

  /// No description provided for @legalTermsSection6Body.
  ///
  /// In es, this message translates to:
  /// **'FinanSys no se responsabiliza por decisiones financieras tomadas con base en la información mostrada en la aplicación. La información de tasas de cambio es referencial y puede variar. No garantizamos la disponibilidad continua del servicio.'**
  String get legalTermsSection6Body;

  /// No description provided for @legalTermsSection7Title.
  ///
  /// In es, this message translates to:
  /// **'Propiedad Intelectual'**
  String get legalTermsSection7Title;

  /// No description provided for @legalTermsSection7Body.
  ///
  /// In es, this message translates to:
  /// **'Todo el contenido, diseño, código y funcionalidades de FinanSys son propiedad de sus desarrolladores. No se permite reproducir, distribuir o crear trabajos derivados sin autorización expresa por escrito.'**
  String get legalTermsSection7Body;

  /// No description provided for @legalTermsSection8Title.
  ///
  /// In es, this message translates to:
  /// **'Modificaciones'**
  String get legalTermsSection8Title;

  /// No description provided for @legalTermsSection8Body.
  ///
  /// In es, this message translates to:
  /// **'Nos reservamos el derecho de modificar estos términos en cualquier momento. Los cambios entrarán en vigor al ser publicados en la aplicación. El uso continuado del servicio después de los cambios constituye aceptación de los nuevos términos.'**
  String get legalTermsSection8Body;

  /// No description provided for @legalTermsSection9Title.
  ///
  /// In es, this message translates to:
  /// **'Cancelación de Cuenta'**
  String get legalTermsSection9Title;

  /// No description provided for @legalTermsSection9Body.
  ///
  /// In es, this message translates to:
  /// **'Puede cancelar su cuenta en cualquier momento. Al hacerlo, todos sus datos serán eliminados permanentemente de nuestros servidores. Nos reservamos el derecho de suspender cuentas que violen estos términos.'**
  String get legalTermsSection9Body;

  /// No description provided for @legalTermsSection10Title.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get legalTermsSection10Title;

  /// No description provided for @legalTermsSection10Body.
  ///
  /// In es, this message translates to:
  /// **'Para preguntas sobre estos Términos y Condiciones puede contactarnos a través de la aplicación. Haremos nuestro mejor esfuerzo para responder en un plazo razonable.'**
  String get legalTermsSection10Body;

  /// No description provided for @legalTermsAppBarTitle.
  ///
  /// In es, this message translates to:
  /// **'Términos y Condiciones'**
  String get legalTermsAppBarTitle;

  /// No description provided for @legalTermsTitle.
  ///
  /// In es, this message translates to:
  /// **'Términos y Condiciones de Uso'**
  String get legalTermsTitle;

  /// No description provided for @legalLastUpdated.
  ///
  /// In es, this message translates to:
  /// **'Última actualización: octubre 2026'**
  String get legalLastUpdated;

  /// No description provided for @legalTermsFooterNote.
  ///
  /// In es, this message translates to:
  /// **'Al crear una cuenta en FinanSys, confirmas que has leído, entendido y aceptado estos Términos y Condiciones en su totalidad.'**
  String get legalTermsFooterNote;

  /// No description provided for @legalTermsAcceptButton.
  ///
  /// In es, this message translates to:
  /// **'Entendido, acepto los términos'**
  String get legalTermsAcceptButton;

  /// No description provided for @legalPrivacySection1Title.
  ///
  /// In es, this message translates to:
  /// **'Responsable del Tratamiento'**
  String get legalPrivacySection1Title;

  /// No description provided for @legalPrivacySection1Body.
  ///
  /// In es, this message translates to:
  /// **'FinanSys, aplicación de gestión de finanzas personales desarrollada como proyecto académico por estudiantes de la Universidad de Cundinamarca, es responsable del tratamiento de los datos personales recopilados a través de esta plataforma.'**
  String get legalPrivacySection1Body;

  /// No description provided for @legalPrivacySection2Title.
  ///
  /// In es, this message translates to:
  /// **'Datos Personales Recopilados'**
  String get legalPrivacySection2Title;

  /// No description provided for @legalPrivacySection2Body.
  ///
  /// In es, this message translates to:
  /// **'Recopilamos los siguientes datos personales:\n\n• Nombre completo\n• Nombre de usuario (username)\n• Correo electrónico\n• Contraseña (almacenada en formato cifrado con bcrypt)\n• Información financiera: ingresos, gastos, presupuestos y conversiones de divisas registradas por el usuario\n• Datos de actividad: fecha y hora de acceso, dirección IP'**
  String get legalPrivacySection2Body;

  /// No description provided for @legalPrivacySection3Title.
  ///
  /// In es, this message translates to:
  /// **'Finalidad del Tratamiento'**
  String get legalPrivacySection3Title;

  /// No description provided for @legalPrivacySection3Body.
  ///
  /// In es, this message translates to:
  /// **'Los datos personales recopilados se utilizan exclusivamente para:\n\n• Autenticación y acceso seguro a la cuenta\n• Prestación del servicio de gestión financiera personal\n• Personalización de la experiencia del usuario\n• Monitoreo de seguridad y detección de accesos no autorizados\n• Mejora continua del servicio'**
  String get legalPrivacySection3Body;

  /// No description provided for @legalPrivacySection4Title.
  ///
  /// In es, this message translates to:
  /// **'Derechos del Titular'**
  String get legalPrivacySection4Title;

  /// No description provided for @legalPrivacySection4Body.
  ///
  /// In es, this message translates to:
  /// **'Como titular de sus datos personales, usted tiene derecho a:\n\n• Conocer, actualizar y rectificar sus datos\n• Solicitar prueba de la autorización otorgada\n• Ser informado sobre el uso de sus datos\n• Revocar la autorización y solicitar la eliminación de sus datos\n• Acceder gratuitamente a sus datos personales\n\nPuede ejercer estos derechos directamente desde la configuración de su cuenta.'**
  String get legalPrivacySection4Body;

  /// No description provided for @legalPrivacySection5Title.
  ///
  /// In es, this message translates to:
  /// **'Seguridad de los Datos'**
  String get legalPrivacySection5Title;

  /// No description provided for @legalPrivacySection5Body.
  ///
  /// In es, this message translates to:
  /// **'Implementamos medidas técnicas y organizativas para proteger sus datos:\n\n• Contraseñas cifradas con algoritmo bcrypt (salt rounds: 10)\n• Autenticación mediante tokens JWT con expiración de 24 horas\n• Cierre automático de sesión por inactividad\n• Registro de accesos y actividad para auditoría\n• Comunicación cifrada mediante HTTPS'**
  String get legalPrivacySection5Body;

  /// No description provided for @legalPrivacySection6Title.
  ///
  /// In es, this message translates to:
  /// **'Compartición de Datos'**
  String get legalPrivacySection6Title;

  /// No description provided for @legalPrivacySection6Body.
  ///
  /// In es, this message translates to:
  /// **'Sus datos personales NO serán vendidos, arrendados ni compartidos con terceros con fines comerciales. Solo podrán ser divulgados en los siguientes casos:\n\n• Por orden judicial o requerimiento de autoridad competente\n• Cuando sea necesario para proteger los derechos de otros usuarios\n• Con proveedores de servicios técnicos estrictamente necesarios para el funcionamiento de la plataforma, bajo acuerdos de confidencialidad'**
  String get legalPrivacySection6Body;

  /// No description provided for @legalPrivacySection7Title.
  ///
  /// In es, this message translates to:
  /// **'Retención de Datos'**
  String get legalPrivacySection7Title;

  /// No description provided for @legalPrivacySection7Body.
  ///
  /// In es, this message translates to:
  /// **'Sus datos se conservarán mientras mantenga una cuenta activa en FinanSys. Al eliminar su cuenta, todos sus datos personales y financieros serán eliminados permanentemente de nuestros servidores en un plazo máximo de 30 días.'**
  String get legalPrivacySection7Body;

  /// No description provided for @legalPrivacySection8Title.
  ///
  /// In es, this message translates to:
  /// **'Cookies y Almacenamiento Local'**
  String get legalPrivacySection8Title;

  /// No description provided for @legalPrivacySection8Body.
  ///
  /// In es, this message translates to:
  /// **'FinanSys utiliza almacenamiento local del navegador (localStorage) exclusivamente para mantener la sesión del usuario mediante un token de autenticación. No utilizamos cookies de rastreo ni publicidad.'**
  String get legalPrivacySection8Body;

  /// No description provided for @legalPrivacySection9Title.
  ///
  /// In es, this message translates to:
  /// **'Transferencias Internacionales'**
  String get legalPrivacySection9Title;

  /// No description provided for @legalPrivacySection9Body.
  ///
  /// In es, this message translates to:
  /// **'Los datos son almacenados en servidores locales o en servicios de nube con sede en jurisdicciones que cuentan con estándares adecuados de protección de datos. No realizamos transferencias internacionales de datos sin las garantías adecuadas.'**
  String get legalPrivacySection9Body;

  /// No description provided for @legalPrivacySection10Title.
  ///
  /// In es, this message translates to:
  /// **'Cambios en la Política'**
  String get legalPrivacySection10Title;

  /// No description provided for @legalPrivacySection10Body.
  ///
  /// In es, this message translates to:
  /// **'Nos reservamos el derecho de actualizar esta política. Los cambios serán notificados a través de la aplicación. El uso continuado del servicio tras la notificación implica aceptación de la nueva política.'**
  String get legalPrivacySection10Body;

  /// No description provided for @legalPrivacyAppBarTitle.
  ///
  /// In es, this message translates to:
  /// **'Política de Tratamiento de Datos'**
  String get legalPrivacyAppBarTitle;

  /// No description provided for @legalPrivacyTitle.
  ///
  /// In es, this message translates to:
  /// **'Política de Tratamiento de Datos Personales'**
  String get legalPrivacyTitle;

  /// No description provided for @legalPrivacyIntro.
  ///
  /// In es, this message translates to:
  /// **'De conformidad con la Ley 1581 de 2012 y el Decreto 1377 de 2013 de la República de Colombia, FinanSys informa su política de tratamiento de datos personales.'**
  String get legalPrivacyIntro;

  /// No description provided for @legalPrivacyFooterNote.
  ///
  /// In es, this message translates to:
  /// **'Al usar FinanSys usted autoriza el tratamiento de sus datos personales de acuerdo con esta política, en cumplimiento de la Ley 1581 de 2012.'**
  String get legalPrivacyFooterNote;

  /// No description provided for @legalPrivacyAcceptButton.
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get legalPrivacyAcceptButton;

  /// No description provided for @errValidationMissingFields.
  ///
  /// In es, this message translates to:
  /// **'Faltan datos requeridos: {fields}'**
  String errValidationMissingFields(String fields);

  /// No description provided for @errValidationUsernameFormat.
  ///
  /// In es, this message translates to:
  /// **'Usuario inválido: solo letras, números y _ (3-20 caracteres)'**
  String get errValidationUsernameFormat;

  /// No description provided for @errValidationPasswordMin.
  ///
  /// In es, this message translates to:
  /// **'La contraseña debe tener mínimo {min} caracteres'**
  String errValidationPasswordMin(int min);

  /// No description provided for @errValidationNothingToUpdate.
  ///
  /// In es, this message translates to:
  /// **'Debes enviar al menos un campo para actualizar'**
  String get errValidationNothingToUpdate;

  /// No description provided for @errValidationInvalidTheme.
  ///
  /// In es, this message translates to:
  /// **'Tema inválido'**
  String get errValidationInvalidTheme;

  /// No description provided for @errValidationInvalidFormat.
  ///
  /// In es, this message translates to:
  /// **'Formato inválido: usa PDF o Excel'**
  String get errValidationInvalidFormat;

  /// No description provided for @errValidationInvalidMonth.
  ///
  /// In es, this message translates to:
  /// **'Mes inválido (1 a 12)'**
  String get errValidationInvalidMonth;

  /// No description provided for @errValidationInvalidYear.
  ///
  /// In es, this message translates to:
  /// **'Año inválido'**
  String get errValidationInvalidYear;

  /// No description provided for @errValidationInvalidUid.
  ///
  /// In es, this message translates to:
  /// **'Identificador de usuario inválido'**
  String get errValidationInvalidUid;

  /// No description provided for @errAuthUserNotFound.
  ///
  /// In es, this message translates to:
  /// **'Usuario no encontrado'**
  String get errAuthUserNotFound;

  /// No description provided for @errAuthWrongPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña incorrecta'**
  String get errAuthWrongPassword;

  /// No description provided for @errAuthTokenMissing.
  ///
  /// In es, this message translates to:
  /// **'No has iniciado sesión'**
  String get errAuthTokenMissing;

  /// No description provided for @errAuthTokenInvalid.
  ///
  /// In es, this message translates to:
  /// **'Tu sesión no es válida. Inicia sesión de nuevo.'**
  String get errAuthTokenInvalid;

  /// No description provided for @errSesionCerrada.
  ///
  /// In es, this message translates to:
  /// **'Tu sesión ya no es válida. Inicia sesión de nuevo.'**
  String get errSesionCerrada;

  /// No description provided for @errSesionReemplazada.
  ///
  /// In es, this message translates to:
  /// **'Tu cuenta se abrió en otra ventana o dispositivo, por eso se cerró esta sesión.'**
  String get errSesionReemplazada;

  /// No description provided for @errAuthSessionCheckFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo verificar la sesión'**
  String get errAuthSessionCheckFailed;

  /// No description provided for @errAuthForbiddenAdminOnly.
  ///
  /// In es, this message translates to:
  /// **'Acceso solo para administradores'**
  String get errAuthForbiddenAdminOnly;

  /// No description provided for @errAuthAccountDisabled.
  ///
  /// In es, this message translates to:
  /// **'Cuenta desactivada'**
  String get errAuthAccountDisabled;

  /// No description provided for @errAuthResetLinkInvalid.
  ///
  /// In es, this message translates to:
  /// **'El enlace es inválido o ha expirado'**
  String get errAuthResetLinkInvalid;

  /// No description provided for @errAuthGoogleTokenMissing.
  ///
  /// In es, this message translates to:
  /// **'Falta el token de Google'**
  String get errAuthGoogleTokenMissing;

  /// No description provided for @errAuthGoogleTokenInvalid.
  ///
  /// In es, this message translates to:
  /// **'Token de Google inválido o vencido'**
  String get errAuthGoogleTokenInvalid;

  /// No description provided for @errAuthGoogleEmailUnverified.
  ///
  /// In es, this message translates to:
  /// **'Tu correo de Google no está verificado'**
  String get errAuthGoogleEmailUnverified;

  /// No description provided for @errAuthGoogleNotConfigured.
  ///
  /// In es, this message translates to:
  /// **'El inicio con Google no está configurado en el servidor'**
  String get errAuthGoogleNotConfigured;

  /// No description provided for @errConflictEmailTaken.
  ///
  /// In es, this message translates to:
  /// **'El correo ya está registrado'**
  String get errConflictEmailTaken;

  /// No description provided for @errConflictUsernameTaken.
  ///
  /// In es, this message translates to:
  /// **'El username ya está en uso'**
  String get errConflictUsernameTaken;

  /// No description provided for @errNotFoundExpense.
  ///
  /// In es, this message translates to:
  /// **'Gasto no encontrado'**
  String get errNotFoundExpense;

  /// No description provided for @errNotFoundRoute.
  ///
  /// In es, this message translates to:
  /// **'Recurso no encontrado'**
  String get errNotFoundRoute;

  /// No description provided for @errRateLimitDaily.
  ///
  /// In es, this message translates to:
  /// **'Límite diario alcanzado ({limit} solicitudes). Intenta mañana.'**
  String errRateLimitDaily(int limit);

  /// No description provided for @errExternalRateFetchFailed.
  ///
  /// In es, this message translates to:
  /// **'Error consultando la tasa de cambio'**
  String get errExternalRateFetchFailed;

  /// No description provided for @errExternalConvertFailed.
  ///
  /// In es, this message translates to:
  /// **'Error convirtiendo la moneda'**
  String get errExternalConvertFailed;

  /// No description provided for @errInternalError.
  ///
  /// In es, this message translates to:
  /// **'Error interno del servidor'**
  String get errInternalError;

  /// No description provided for @errNetwork.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión. Verifica que el servidor esté corriendo.'**
  String get errNetwork;

  /// No description provided for @errUnknown.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error inesperado'**
  String get errUnknown;

  /// No description provided for @authUsernameAvailable.
  ///
  /// In es, this message translates to:
  /// **'Usuario disponible'**
  String get authUsernameAvailable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
