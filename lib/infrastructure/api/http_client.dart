// infrastructure/api/http_client.dart
// Cliente HTTP base — todas las peticiones al backend pasan por aquí.
// Parsea la estructura { ok, data } y { ok, msg } del backend Node.js.
// SOLID-SRP: única responsabilidad — ejecutar peticiones HTTP.

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../core/env/app_env.dart';
import '../../core/errors/app_errors.dart';
import '../../core/session/session_events.dart';
import '../../domain/ports/storage_port.dart';

class HttpClient {
  final StoragePort _storage;
  final Duration _timeout = const Duration(seconds: 10);

  HttpClient(this._storage);

  // ── Headers con o sin JWT ──
  Future<Map<String, String>> _buildHeaders({bool requiresAuth = false}) async {
    final headers = {'Content-Type': 'application/json'};
    if (requiresAuth) {
      final token = await _storage.getToken();
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // ── Parsea { ok, data } o { ok, code, params, msg } del backend ──
  Map<String, dynamic> _parseResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final code = body['code'] as String?;
    final rawParams = body['params'];
    final params =
        rawParams is Map<String, dynamic> ? rawParams : <String, dynamic>{};
    final msg = body['msg'] as String?;
    switch (response.statusCode) {
      case 401:
        // Sesión única: el servidor avisa si esta sesión fue reemplazada o cerrada
        if (code == 'SESION_REEMPLAZADA' || code == 'SESION_CERRADA') {
          final m = msg ?? 'Tu sesión ya no es válida';
          SessionEvents.onInvalid?.call(code!, m);
          throw SessionReplacedError(m, code!);
        }
        throw UnauthorizedError(msg ?? 'No autorizado', code, params);
      case 403:
        throw ForbiddenError(
            msg ?? 'No tienes permiso para esta acción', code, params);
      case 404:
        throw NotFoundError(msg ?? 'No encontrado', code, params);
      case 409:
        throw ConflictError(msg ?? 'Ya existe', code, params);
      case 400:
        throw ValidationError(msg ?? 'Datos inválidos', code, params);
    }
    if (response.statusCode >= 500) {
      throw ServerError(msg ?? 'Error del servidor', code, params);
    }
    return body;
  }

  // ── GET ──
  Future<Map<String, dynamic>> get(
    String path, {
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _buildHeaders(requiresAuth: requiresAuth);
      final response = await http
          .get(Uri.parse('${AppEnv.apiBaseUrl}$path'), headers: headers)
          .timeout(_timeout);
      return _parseResponse(response);
    } on AppError {
      rethrow;
    } catch (_) {
      throw const NetworkError();
    }
  }

  // ── GET de un archivo (PDF, Excel...) — devuelve los bytes ──
  Future<Uint8List> getBytes(
    String path, {
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _buildHeaders(requiresAuth: requiresAuth);
      final response = await http
          .get(Uri.parse('${AppEnv.apiBaseUrl}$path'), headers: headers)
          .timeout(
              const Duration(seconds: 60)); // generar el archivo puede tardar
      if (response.statusCode >= 400) {
        // Los errores llegan como JSON { ok:false, msg }: _parseResponse los traduce
        _parseResponse(response); // lanza el error tipado (con code/params)
        throw AppError('No se pudo generar el archivo',
            statusCode: response.statusCode);
      }
      return response.bodyBytes;
    } on AppError {
      rethrow;
    } catch (_) {
      throw const NetworkError();
    }
  }

  // ── POST ──
  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body, {
    bool requiresAuth = false,
  }) async {
    try {
      final headers = await _buildHeaders(requiresAuth: requiresAuth);
      final response = await http
          .post(
            Uri.parse('${AppEnv.apiBaseUrl}$path'),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(_timeout);
      return _parseResponse(response);
    } on AppError {
      rethrow;
    } catch (_) {
      throw const NetworkError();
    }
  }

  // ── PUT ──
  Future<Map<String, dynamic>> put(
    String path,
    Map<String, dynamic> body, {
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _buildHeaders(requiresAuth: requiresAuth);
      final response = await http
          .put(
            Uri.parse('${AppEnv.apiBaseUrl}$path'),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(_timeout);
      return _parseResponse(response);
    } on AppError {
      rethrow;
    } catch (_) {
      throw const NetworkError();
    }
  }

  // ── DELETE ──
  Future<Map<String, dynamic>> delete(
    String path, {
    bool requiresAuth = true,
  }) async {
    try {
      final headers = await _buildHeaders(requiresAuth: requiresAuth);
      final response = await http
          .delete(Uri.parse('${AppEnv.apiBaseUrl}$path'), headers: headers)
          .timeout(_timeout);
      return _parseResponse(response);
    } on AppError {
      rethrow;
    } catch (_) {
      throw const NetworkError();
    }
  }
}
