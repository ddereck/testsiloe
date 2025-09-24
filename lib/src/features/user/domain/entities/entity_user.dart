import 'package:equatable/equatable.dart';

class EntityUser extends Equatable {
  final int? id;
  final String? email;
  final String? name;
  final String? password;
  final String? emailVerifiedAt;
  final String? firebaseId;
  final String? tel;
  final String? photo;
  final String? statut;
  final String? profil;
  final String? token;
  final List<String> roles;

  const EntityUser({
    this.id,
    this.email,
    this.name,
    this.password,
    this.emailVerifiedAt,
    this.firebaseId,
    this.tel,
    this.photo,
    this.statut,
    this.profil,
    this.token,
    this.roles = const [],
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'tel': tel,
      'photo': photo,
      'statut': statut,
      'profil': profil,
      'token': token,
      'roles': roles,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        password,
        emailVerifiedAt,
        firebaseId,
        tel,
        photo,
        statut,
        profil,
        token,
        roles,
      ];
}
