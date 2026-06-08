import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:places/data/api_service.dart';
import 'package:places/data/models/place_review_models.dart';

// ─── Auth State ──────────────────────────────────────────────────────────────
// Guardamos el token JWT y el nombre de usuario tras el login.

class AuthState {
  final String? token;
  final String? usuario;
  final List<String> roles;

  const AuthState({this.token, this.usuario, this.roles = const []});

  bool get isLoggedIn => token != null;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final usuario = prefs.getString('auth_usuario');
    if (token != null) {
      state = AuthState(token: token, usuario: usuario);
    }
  }

  Future<void> login(String token, String usuario, List<String> roles) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('auth_usuario', usuario);
    state = AuthState(token: token, usuario: usuario, roles: roles);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_usuario');
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// ─── Places Provider ─────────────────────────────────────────────────────────
// Cachea automáticamente la lista de lugares una vez obtenida.

final placesProvider = FutureProvider<List<PlaceModel>>((ref) async {
  return await ApiService.getPlaces();
});

// ─── Reviews Provider ────────────────────────────────────────────────────────
// Parametrizado: cada placeId tiene su propia caché independiente.

final reviewsProvider =
    FutureProvider.family<List<ReviewModel>, int>((ref, placeId) async {
  return await ApiService.getReviews(placeId);
});
