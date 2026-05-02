// core/env/app_env.dart
// Factor III (12-Factor App): configuración separada del código.
// SOLID-SRP: única responsabilidad — leer variables de entorno.

class AppEnv {
  AppEnv._(); // constructor privado, no instanciable

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1',
  );

  static const String tokenKey = String.fromEnvironment(
    'TOKEN_KEY',
    defaultValue: 'finansys_jwt_token',
  );

  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'FinanSys',
  );

  static const String appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '2.0.0',
  );
}
