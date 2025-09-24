import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_don.dart';

/// A class that extends [EntityDon] and overrides the [toJson] and [copyWith] methods
class ModelDon extends EntityDon {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelDon({ super.id, super.utilisateurId, super.nomAffiche, super.montant, super.reseau, super.anonyme, super.status, super.createdAt, super.updatedAt });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelDon.fromJson(Map<String, dynamic> json) {
    return ModelDon(
      id: json[DatabaseAttributesResources.id],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
      nomAffiche: json[DatabaseAttributesResources.nomAffiche],
      montant: json[DatabaseAttributesResources.montant],
      reseau: json[DatabaseAttributesResources.reseau],
      anonyme: json[DatabaseAttributesResources.anonyme],
      status: json[DatabaseAttributesResources.status],
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
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.nomAffiche: nomAffiche,
      DatabaseAttributesResources.montant: montant,
      DatabaseAttributesResources.reseau: reseau,
      DatabaseAttributesResources.anonyme: anonyme,
      DatabaseAttributesResources.status: status,
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
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.nomAffiche: nomAffiche,
      DatabaseAttributesResources.montant: montant,
      DatabaseAttributesResources.reseau: reseau,
      DatabaseAttributesResources.anonyme: anonyme,
      DatabaseAttributesResources.status: status,
      DatabaseAttributesResources.createdAt: createdAt,
      DatabaseAttributesResources.updatedAt: updatedAt,
    };
  }

  /// A factory method that creates a new instance of the model from an [EntityDon]
  /// 
  /// It takes an [EntityDon] and returns a new instance of the model
  factory ModelDon.fromEntity(EntityDon entity) {
    return ModelDon(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      nomAffiche: entity.nomAffiche,
      montant: entity.montant,
      reseau: entity.reseau,
      anonyme: entity.anonyme,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// A method that returns a new instance of [EntityDon] from the model
  /// 
  /// It takes the model and returns a new instance of [EntityDon]
  EntityDon toEntity() {
    return EntityDon(
      id: id,
      utilisateurId: utilisateurId,
      nomAffiche: nomAffiche,
      montant: montant,
      reseau: reseau,
      anonyme: anonyme,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelDon copyWith(
    { int? id, int? utilisateurId, String? nomAffiche, int? montant, String? reseau, bool? anonyme, String? status, String? createdAt, String? updatedAt, }
  ) {
    return ModelDon(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      nomAffiche: nomAffiche ?? this.nomAffiche,
      montant: montant ?? this.montant,
      reseau: reseau ?? this.reseau,
      anonyme: anonyme ?? this.anonyme,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
