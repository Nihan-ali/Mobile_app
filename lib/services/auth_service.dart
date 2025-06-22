import 'dart:async';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  AuthService._internal();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Simulate login API call
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    if (email == 'test@example.com' && password == 'password123') {
      _isLoggedIn = true;
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
  }
}
