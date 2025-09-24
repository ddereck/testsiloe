import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_commentaire_report.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelCommentaireReport extends EntityCommentaireReport {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelCommentaireReport({ super.id, super.utilisateurId, super.commentaireId, super.raison });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelCommentaireReport.fromJson(Map<String, dynamic> json) {
    return ModelCommentaireReport(
      id: json[DatabaseAttributesResources.id],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
      commentaireId: json[DatabaseAttributesResources.commentaireId],
      raison: json[DatabaseAttributesResources.raison],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.commentaireId: commentaireId,
      DatabaseAttributesResources.raison: raison,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.commentaireId: commentaireId,
      DatabaseAttributesResources.raison: raison,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelCommentaireReport.fromEntity(EntityCommentaireReport entity) {
    return ModelCommentaireReport(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      commentaireId: entity.commentaireId,
      raison: entity.raison,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityCommentaireReport toEntity() {
    return EntityCommentaireReport(
      id: id,
      utilisateurId: utilisateurId,
      commentaireId: commentaireId,
      raison: raison,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelCommentaireReport copyWith(
    { int? id, int? utilisateurId, int? commentaireId, String? raison }
  ) {
    return ModelCommentaireReport(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      commentaireId: commentaireId ?? this.commentaireId,
      raison: raison ?? this.raison,
    );
  }
}
