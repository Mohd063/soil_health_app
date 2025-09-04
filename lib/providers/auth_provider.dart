import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soil_health_app/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  AuthProvider() {
    _authService.user.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      User? user = await _authService.signInWithEmailAndPassword(email, password);
      return user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      User? user = await _authService.registerWithEmailAndPassword(email, password);
      return user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}