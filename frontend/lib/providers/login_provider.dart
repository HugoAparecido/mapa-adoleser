// providers/register_provider.dart
import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/helpers/error_handler.dart';
import 'package:mapa_adoleser/data/services/auth_service.dart';
import 'package:mapa_adoleser/domain/requests/login_request_model.dart';
import 'package:mapa_adoleser/domain/models/user_model.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _error;
  bool _loading = false;

  String? get error => _error;
  bool get isLoading => _loading;

  Future<(UserModel, String)?> login(String email, String password) async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final request = LoginRequestModel(email: email, password: password);
      final (UserModel, String) responseData =
          await _authService.login(request);

      final String token = responseData.$2;

      final UserModel user = responseData.$1;

      _loading = false;
      notifyListeners();

      return (user, token);
    } catch (e) {
      _error = parseException(e);
      _loading = false;
      notifyListeners();
      return null;
    }
  }
}
