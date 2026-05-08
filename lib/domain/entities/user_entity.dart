// domain/entities/user_entity.dart
// Entidad pura — correlacionada con user.entity.js del backend.
// Campos: uid, email, username (password nunca se guarda en el front)
// SOLID-SRP: representa únicamente el concepto de Usuario.

class UserEntity {
  final int uid;
  final String email;
  final String username;
  final bool activo;
  final DateTime? createdAt;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.username,
    this.activo = true,
    this.createdAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      uid: json['uid'] ?? json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      activo: json['activo'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
      };
}
