import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_commentaire.dart';

/// A class that extends [EntityCommentaire] and overrides the [toJson] and [copyWith] methods
class ModelCommentaire extends EntityCommentaire {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelCommentaire({ super.id, super.utilisateurId, super.publicationId, super.nom, 
  super.photo, super.contenu, super.parentId, super.statut, super.createdAt });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelCommentaire.fromJson(Map<String, dynamic> json) {
    return ModelCommentaire(
      id: json[DatabaseAttributesResources.id] != null ? int.parse("${json[DatabaseAttributesResources.id]}") : null,
      utilisateurId: json[DatabaseAttributesResources.utilisateurId] != null ? int.parse("${json[DatabaseAttributesResources.utilisateurId]}") : null,
      publicationId: json[DatabaseAttributesResources.publicationId] != null ? int.parse("${json[DatabaseAttributesResources.publicationId]}") : null,
      nom: json[DatabaseAttributesResources.nom],
      photo: json[DatabaseAttributesResources.photo],
      contenu: json[DatabaseAttributesResources.contenu],
      parentId: json[DatabaseAttributesResources.parentId] != null ? int.parse("${json[DatabaseAttributesResources.parentId]}") : null,
      statut: json[DatabaseAttributesResources.statut],
      createdAt: json[DatabaseAttributesResources.createdAt],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.publicationId: publicationId,
      DatabaseAttributesResources.nom: nom,
      DatabaseAttributesResources.photo: photo,
      DatabaseAttributesResources.contenu: contenu,
      DatabaseAttributesResources.parentId: parentId,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.createdAt: createdAt,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.publicationId: publicationId,
      DatabaseAttributesResources.nom: nom,
      DatabaseAttributesResources.photo: photo,
      DatabaseAttributesResources.contenu: contenu,
      DatabaseAttributesResources.parentId: parentId,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.createdAt: createdAt,
    };
  }

  /// A factory method that creates a new instance of the model from an [EntityCommentaire]
  /// 
  /// It takes an [EntityCommentaire] and returns a new instance of the model
  factory ModelCommentaire.fromEntity(EntityCommentaire entity) {
    return ModelCommentaire(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      publicationId: entity.publicationId,
      nom: entity.nom,
      photo: entity.photo,
      contenu: entity.contenu,
      parentId: entity.parentId,
      statut: entity.statut,
      createdAt: entity.createdAt,
    );
  }

  /// A method that returns a new instance of [EntityCommentaire] from the model
  /// 
  /// It takes the model and returns a new instance of [EntityCommentaire]
  EntityCommentaire toEntity() {
    return EntityCommentaire(
      id: id,
      utilisateurId: utilisateurId,
      publicationId: publicationId,
      nom: nom,
      photo: photo,
      contenu: contenu,
      parentId: parentId,
      statut: statut,
      createdAt: createdAt,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelCommentaire copyWith(
    { int? id, int? utilisateurId, int? publicationId, String? nom, String? photo, String? contenu, int? parentId, String? statut, String? createdAt,}
  ) {
    return ModelCommentaire(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      publicationId: publicationId ?? this.publicationId,
      nom: nom ?? this.nom,
      photo: photo ?? this.photo,
      contenu: contenu ?? this.contenu,
      parentId: parentId ?? this.parentId,
      statut: statut ?? this.statut,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
