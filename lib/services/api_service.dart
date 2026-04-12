import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // ── Cambia esta IP por la de tu PC cuando corras el backend ──
  static const String baseUrl = 'http://127.0.0.1:3000/api/v1/users';
  static const String _tokenKey = 'finansys_token';

  // ── Guardar / leer / borrar token ──
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // ── POST /register ──
  // Body: { email, password, username }
  // Response: { ok, user, token }
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'username': username,
      }),
    );
    return jsonDecode(res.body);
  }

  // ── POST /login ──
  // Body: { email, password }
  // Response: { ok, msg, token }
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(res.body);
  }

  // ── GET /profile  (requiere token JWT) ──
  // Response: { ok, user: { id, email, username } }
  static Future<Map<String, dynamic>> profile() async {
    final token = await getToken();
    final res = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(res.body);
  }

  // ── GET / (lista todos los usuarios) ──
  static Future<Map<String, dynamic>> getUsers() async {
    final res = await http.get(Uri.parse(baseUrl));
    return jsonDecode(res.body);
  }
}
