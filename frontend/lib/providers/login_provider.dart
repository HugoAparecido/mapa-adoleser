// providers/register_provider.dart
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/requests/login_request_model.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _error;
  bool _loading = false;

  String? get error => _error;
  bool get isLoading => _loading;

  Future<bool> login(
      String email, String password, AuthProvider authProvider) async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final request = LoginRequestModel(email: email, password: password);

      final (userModel, accessToken, refreshToken) =
          await _authService.login(request);

      await authProvider.saveAuthData(userModel, accessToken, refreshToken);

      _loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _error = parseException(e);
      _loading = false;
      notifyListeners();
      return false;
    }
  }
}
