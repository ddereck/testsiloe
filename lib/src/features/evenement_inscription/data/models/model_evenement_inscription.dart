import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_evenement_inscription.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelEvenementInscription extends EntityEvenementInscription {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelEvenementInscription({ super.id, super.utilisateurId, super.evenementId, super.statut, super.commentaire, super.dateInscription });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelEvenementInscription.fromJson(Map<String, dynamic> json) {
    return ModelEvenementInscription(
      id: json[DatabaseAttributesResources.id],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
      evenementId: json[DatabaseAttributesResources.evenementId],
      statut: json[DatabaseAttributesResources.statut],
      commentaire: json[DatabaseAttributesResources.commentaire],
      dateInscription: json[DatabaseAttributesResources.dateInscription],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.evenementId: evenementId,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.commentaire: commentaire,
      DatabaseAttributesResources.dateInscription: dateInscription,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.evenementId: evenementId,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.commentaire: commentaire,
      DatabaseAttributesResources.dateInscription: dateInscription,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelEvenementInscription.fromEntity(EntityEvenementInscription entity) {
    return ModelEvenementInscription(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      evenementId: entity.evenementId,
      statut: entity.statut,
      commentaire: entity.commentaire,
      dateInscription: entity.dateInscription,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityEvenementInscription toEntity() {
    return EntityEvenementInscription(
      id: id,
      utilisateurId: utilisateurId,
      evenementId: evenementId,
      statut: statut,
      commentaire: commentaire,
      dateInscription: dateInscription,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelEvenementInscription copyWith(
    { int? id, int? utilisateurId, int? evenementId, String? statut, String? commentaire, String? dateInscription }
  ) {
    return ModelEvenementInscription(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      evenementId: evenementId ?? this.evenementId,
      statut: statut ?? this.statut,
      commentaire: commentaire ?? this.commentaire,
      dateInscription: dateInscription ?? this.dateInscription,
    );
  }
}
