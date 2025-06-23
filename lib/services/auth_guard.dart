// lib/screens/home_guard.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '/screens/auth/sign_in_screen.dart';
import '/screens/feed/home_page.dart';

class HomeGuard extends StatelessWidget {
  const HomeGuard({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    if (!authService.isLoggedIn) {
      // Redirect to login if not authorized
      return const SignInScreen();
    }

    // Authorized
    return const HomePage();
  }
}
