enum UserRoleEnums {
  admin,
  user,
  reverend,
  editeur,
  ;

  bool get isAdmin => this == UserRoleEnums.admin;
  bool get isUser => this == UserRoleEnums.user;
  bool get isReverend => this == UserRoleEnums.reverend;
  bool get isEditeur => this == UserRoleEnums.editeur;
  bool get isAdminOrReverend => this == UserRoleEnums.admin || this == UserRoleEnums.reverend;
  bool get isAdminOrReverendOrEditeur => this == UserRoleEnums.admin || this == UserRoleEnums.reverend || this == UserRoleEnums.editeur; 
}

extension UserRoleEnumsExtension on String {
  UserRoleEnums toUserRole() {
    switch (this) {
      case 'admin':
        return UserRoleEnums.admin;
      case 'reverend':
        return UserRoleEnums.reverend;
      case 'editeur':
        return UserRoleEnums.editeur;
      case 'user':
        return UserRoleEnums.user;
      default:
        return UserRoleEnums.user;
    }
  }
}
class UserModel {
  final String? profil;
  final List<String> roles;

  UserModel({this.profil, required this.roles});

  bool hasRole(UserRoleEnums role) {
    return roles.any((r) => r.toUserRole() == role);
  }

  bool get isAdminOrReverendOrEditeur {
    return roles.any((r) {
      final role = r.toUserRole();
      return role.isAdminOrReverendOrEditeur;
    });
  }
}
