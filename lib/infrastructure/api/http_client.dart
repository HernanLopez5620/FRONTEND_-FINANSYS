// infrastructure/api/http_client.dart
// Cliente HTTP base — todas las peticiones al backend pasan por aquí.
// Parsea la estructura { ok, data } y { ok, msg } del backend Node.js.
// SOLID-SRP: única responsabilidad — ejecutar peticiones HTTP.

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/env/app_env.dart';
import '../../core/errors/app_errors.dart';
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

  // ── Parsea { ok, data } o { ok, msg } del backend ──
  Map<String, dynamic> _parseResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    switch (response.statusCode) {
      case 401:
        throw UnauthorizedError(body['msg'] ?? 'No autorizado');
      case 404:
        throw NotFoundError(body['msg'] ?? 'No encontrado');
      case 409:
        throw ConflictError(body['msg'] ?? 'Ya existe');
      case 400:
        throw ValidationError(body['msg'] ?? 'Datos inválidos');
    }
    if (response.statusCode >= 500) {
      throw ServerError(body['msg'] ?? 'Error del servidor');
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
