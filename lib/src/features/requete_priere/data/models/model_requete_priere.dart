import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_requete_priere.dart';

/// A class that extends [EntityRequetePriere] and overrides the [toJson] and [copyWith] methods
class ModelRequetePriere extends EntityRequetePriere {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelRequetePriere({ super.id, super.nomPrenom, super.anonyme, super.contenu, super.statut, super.createdAt, super.updatedAt });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelRequetePriere.fromJson(Map<String, dynamic> json) {
    return ModelRequetePriere(
      id: json[DatabaseAttributesResources.id],
      nomPrenom: json[DatabaseAttributesResources.nomPrenom],
      anonyme: json[DatabaseAttributesResources.anonyme],
      contenu: json[DatabaseAttributesResources.contenu],
      statut: json[DatabaseAttributesResources.statut],
      createdAt: json[DatabaseAttributesResources.createdAt],
      updatedAt: json[DatabaseAttributesResources.updatedAt],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.nomPrenom: nomPrenom,
      DatabaseAttributesResources.anonyme: anonyme,
      DatabaseAttributesResources.contenu: contenu,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.createdAt: createdAt,
      DatabaseAttributesResources.updatedAt: updatedAt,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.nomPrenom: nomPrenom,
      DatabaseAttributesResources.anonyme: anonyme,
      DatabaseAttributesResources.contenu: contenu,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.createdAt: createdAt,
      DatabaseAttributesResources.updatedAt: updatedAt,
    };
  }

  /// A factory method that creates a new instance of the model from an [EntityRequetePriere]
  /// 
  /// It takes an [EntityRequetePriere] and returns a new instance of the model
  factory ModelRequetePriere.fromEntity(EntityRequetePriere entity) {
    return ModelRequetePriere(
      id: entity.id,
      nomPrenom: entity.nomPrenom,
      anonyme: entity.anonyme,
      contenu: entity.contenu,
      statut: entity.statut,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// A method that returns a new instance of [EntityRequetePriere] from the model
  /// 
  /// It takes the model and returns a new instance of [EntityRequetePriere]
  EntityRequetePriere toEntity() {
    return EntityRequetePriere(
      id: id,
      nomPrenom: nomPrenom,
      anonyme: anonyme,
      contenu: contenu,
      statut: statut,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelRequetePriere copyWith(
    { int? id, String? nomPrenom, bool? anonyme, String? contenu, String? statut, String? createdAt, String? updatedAt, }
  ) {
    return ModelRequetePriere(
      id: id ?? this.id,
      nomPrenom: nomPrenom ?? this.nomPrenom,
      anonyme: anonyme ?? this.anonyme,
      contenu: contenu ?? this.contenu,
      statut: statut ?? this.statut,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
    );
  }
}
