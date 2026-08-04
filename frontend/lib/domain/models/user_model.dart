// lib/models/user_model.dart

class UserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final DateTime birthDate;
  final String? avatarUrl;

  UserModel({
    required this.username,
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    this.avatarUrl,
  });

  /// Cria um UserModel a partir do JSON retornado pelo endpoint de login.
  /// Espera a estrutura: { "access": "...", "refresh": "...", "user": { ... } }
  factory UserModel.fromLoginJson(Map<String, dynamic> json) {
    // Entra no objeto "user" da resposta da API
    final userData = json['user'] as Map<String, dynamic>;

    return UserModel(
      id: userData['id'],
      username: userData['username'] ?? '',
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      birthDate: DateTime.parse(
          userData['birth_date'] ?? userData['birthDate'] ?? '1970-01-01'),
      avatarUrl: userData['avatar_url'],
      // REMOVIDO: accessToken e refreshToken não pertencem mais a esta classe!
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      birthDate: DateTime.parse(json['birthDate']),
      avatarUrl: json['avatar_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'avatar_url': avatarUrl,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, name: $name, email: $email, birthDate: ${birthDate.toIso8601String()}, avatarUrl: $avatarUrl}';
  }
}
