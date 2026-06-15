import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:places/data/models/place_review_models.dart';

class AuthResult {
  final bool success;
  final String? token;
  final String? usuario;
  final List<String>? roles;
  final String? errorMessage;

  AuthResult({
    required this.success,
    this.token,
    this.usuario,
    this.roles,
    this.errorMessage,
  });
}

class ApiService {
  static const String baseUrl = 'http://localhost:8080';

  // ─── Auth ──────────────────────────────────────────────────────────────────

  static Future<AuthResult> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'contrasena': password,
        }),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return AuthResult(
          success: true,
          token: data['token'] as String?,
          usuario: data['usuario'] as String?,
          roles: List<String>.from(data['roles'] ?? []),
        );
      } else {
        return AuthResult(
          success: false,
          errorMessage: data['error'] as String? ?? 'Error desconocido del servidor',
        );
      }
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Error de red: No se pudo conectar con el servidor ($e)',
      );
    }
  }

  static Future<AuthResult> register(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/registro'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AuthResult(
          success: true,
          errorMessage: null,
        );
      } else {
        return AuthResult(
          success: false,
          errorMessage: data['error'] as String? ?? 'Error desconocido al registrar',
        );
      }
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Error de red: No se pudo conectar con el servidor ($e)',
      );
    }
  }

  // ─── Places ────────────────────────────────────────────────────────────────

  static Future<List<PlaceModel>> getPlaces() async {
    final response = await http.get(Uri.parse('$baseUrl/api/places'));
    if (response.statusCode == 200) {
      return PlaceModel.fromJsonList(response.body);
    } else {
      throw Exception('Error al cargar lugares: ${response.statusCode}');
    }
  }

  // ─── Reviews ───────────────────────────────────────────────────────────────

  static Future<List<ReviewModel>> getReviews(int placeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/places/$placeId/reviews'),
    );
    if (response.statusCode == 200) {
      return ReviewModel.fromJsonList(response.body);
    } else {
      throw Exception('Error al cargar reseñas: ${response.statusCode}');
    }
  }

  // ─── Crear Reseña ──────────────────────────────────────────────────────────

  static Future<bool> postReview(int placeId, String texto, int estrellas, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/places/$placeId/reviews'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'Texto': texto,
        'Estrellas': estrellas,
      }),
    );
    return response.statusCode == 201;
  }

  // ─── Favoritos ─────────────────────────────────────────────────────────────

  static Future<bool> addFavorite(int placeId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/places/$placeId/favorite'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode == 200;
  }

  static Future<bool> removeFavorite(int placeId, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/places/$placeId/favorite'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode == 200;
  }

  static Future<List<int>> getFavorites(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/favorites'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as int).toList();
    } else {
      return [];
    }
  }
}
