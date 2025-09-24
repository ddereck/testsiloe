class EditeurModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? photo;
  final List<String> roles;

  EditeurModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.photo,
    this.roles = const [],
  });

  factory EditeurModel.fromJson(Map<String, dynamic> json) {
    try {
      return EditeurModel(
        id: _parseInt(json['id']),
        name: _parseString(json['name']),
        email: _parseString(json['email']),
        role: _parseString(json['role']),
        photo: _parseString(json['photo']),
        roles: _parseRoles(json['roles']),
      );
    } catch (e) {
      throw Exception('Erreur lors de la création du modèle EditeurModel: $e');
    }
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static List<String> _parseRoles(dynamic value) {
    if (value == null) return const [];
    try {
      if (value is List) {
        return value
            .map((e) => e is Map<String, dynamic> ? (e['name']?.toString() ?? '') : e.toString())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      return const [];
    } catch (_) {
      return const [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'photo': photo,
      'roles': roles,
    };
  }
}
