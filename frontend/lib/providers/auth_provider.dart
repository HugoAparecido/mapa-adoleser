// providers/register_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final _secureStorage = const FlutterSecureStorage();

  static const String _userKey = 'user_data';
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  UserModel? _user;
  String? _token;

  UserModel? get user => _user;
  bool get isLoggedIn => _token != null;

  AuthProvider() {
    _loadUserFromStorage();
  }

  Future<void> saveAuthData(
      UserModel user, String token, String refreshToken) async {
    _user = user;
    _token = token;

    await _secureStorage.write(key: _tokenKey, value: token);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);

    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(user.toJson());

    await prefs.setString(_userKey, jsonData);

    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    _token = null;

    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);

    notifyListeners();
  }

  Future<void> _loadUserFromStorage() async {
    _token = await _secureStorage.read(key: _tokenKey);

    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(_userKey);

    if (jsonData != null) {
      _user = UserModel.fromJson(jsonDecode(jsonData));
    }

    notifyListeners();
  }

  Future<void> updateUser(UserModel updatedUser) async {
    _user = updatedUser;

    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(updatedUser.toJson());

    await prefs.setString(_userKey, jsonData);

    notifyListeners();
  }
}
