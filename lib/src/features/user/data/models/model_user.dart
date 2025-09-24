import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_user.dart';

/// A class that extends [EntityUser] and overrides the [toJson] and [copyWith] methods
class ModelUser extends EntityUser {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelUser({ super.id, super.email, super.name, super.password, super.emailVerifiedAt, 
    super.firebaseId, super.tel, super.photo, super.statut, super.profil, super.token, super.roles });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      id: json[DatabaseAttributesResources.id],
      email: json[DatabaseAttributesResources.email],
      name: json[DatabaseAttributesResources.name],
      password: json[DatabaseAttributesResources.password],
      emailVerifiedAt: json[DatabaseAttributesResources.emailVerifiedAt],
      firebaseId: json[DatabaseAttributesResources.firebaseId],
      tel: json[DatabaseAttributesResources.tel],
      photo: json[DatabaseAttributesResources.photo],
      statut: json[DatabaseAttributesResources.statut],
      profil: json[DatabaseAttributesResources.profil],
      token: json[DatabaseAttributesResources.token],
      roles: (json['roles'] as List<dynamic>?)
              ?.map((role) {
                final roleMap = role as Map<String, dynamic>;
                return roleMap['name']?.toString() ?? '';
              })
              .where((r) => r.isNotEmpty)
              .toList() 
          ?? [],
      );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.name: name,
      DatabaseAttributesResources.password: password,
      DatabaseAttributesResources.emailVerifiedAt: emailVerifiedAt,
      DatabaseAttributesResources.firebaseId: firebaseId,
      DatabaseAttributesResources.tel: tel,
      DatabaseAttributesResources.photo: photo,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.profil: profil,
      DatabaseAttributesResources.token: token,
      'roles': roles,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.name: name,
      DatabaseAttributesResources.password: password,
      DatabaseAttributesResources.emailVerifiedAt: emailVerifiedAt,
      DatabaseAttributesResources.firebaseId: firebaseId,
      DatabaseAttributesResources.tel: tel,
      DatabaseAttributesResources.photo: photo,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.profil: profil,
      DatabaseAttributesResources.token: token,
      'roles': roles,
    };
  }

  /// A factory method that creates a new instance of the model from an [EntityUser]
  /// 
  /// It takes an [EntityUser] and returns a new instance of the model
  factory ModelUser.fromEntity(EntityUser entity) {
    return ModelUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      password: entity.password,
      emailVerifiedAt: entity.emailVerifiedAt,
      firebaseId: entity.firebaseId,
      tel: entity.tel,
      photo: entity.photo,
      statut: entity.statut,
      profil: entity.profil,
      token: entity.token,
      roles: entity.roles,
    );
  }

  /// A method that returns a new instance of [EntityUser] from the model
  /// 
  /// It takes the model and returns a new instance of [EntityUser]
  EntityUser toEntity() {
    return EntityUser(
      id: id,
      email: email,
      name: name,
      password: password,
      emailVerifiedAt: emailVerifiedAt,
      firebaseId: firebaseId,
      tel: tel,
      photo: photo,
      statut: statut,
      profil: profil,
      token: token,
      roles: roles,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelUser copyWith(
    { int? id, String? email, String? name, String? password, String? emailVerifiedAt, 
    String? firebaseId, String? tel, String? photo, String? statut, String? profil, String? token, 
   List<String>? roles, }
  ) {
    return ModelUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      firebaseId: firebaseId ?? this.firebaseId,
      tel: tel ?? this.tel,
      photo: photo ?? this.photo,
      statut: statut ?? this.statut,
      profil: profil ?? this.profil,
      token: token ?? this.token,
      roles: roles ?? this.roles,
    );
  }
}
