import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_programme.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelProgramme extends EntityProgramme {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelProgramme({ super.id, super.utilisateurId, super.date, super.heure, super.type, super.description, super.statut });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelProgramme.fromJson(Map<String, dynamic> json) {
    return ModelProgramme(
      id: json[DatabaseAttributesResources.id],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
      date: json[DatabaseAttributesResources.date],
      heure: json[DatabaseAttributesResources.heure],
      type: json[DatabaseAttributesResources.type],
      description: json[DatabaseAttributesResources.description],
      statut: json[DatabaseAttributesResources.statut],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.date: date,
      DatabaseAttributesResources.heure: heure,
      DatabaseAttributesResources.type: type,
      DatabaseAttributesResources.description: description,
      DatabaseAttributesResources.statut: statut,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.date: date,
      DatabaseAttributesResources.heure: heure,
      DatabaseAttributesResources.type: type,
      DatabaseAttributesResources.description: description,
      DatabaseAttributesResources.statut: statut,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelProgramme.fromEntity(EntityProgramme entity) {
    return ModelProgramme(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      date: entity.date,
      heure: entity.heure,
      type: entity.type,
      description: entity.description,
      statut: entity.statut,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityProgramme toEntity() {
    return EntityProgramme(
      id: id,
      utilisateurId: utilisateurId,
      date: date,
      heure: heure,
      type: type,
      description: description,
      statut: statut,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelProgramme copyWith(
    { int? id, int? utilisateurId, String? date, String? heure, String? type, String? description, String? statut }
  ) {
    return ModelProgramme(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      date: date ?? this.date,
      heure: heure ?? this.heure,
      type: type ?? this.type,
      description: description ?? this.description,
      statut: statut ?? this.statut,
    );
  }
}
