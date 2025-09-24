import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_commentaire_reaction.dart';

/// A class that extends [EntityCommentaireReaction] and overrides the [toJson] and [copyWith] methods
class ModelCommentaireReaction extends EntityCommentaireReaction {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelCommentaireReaction({ super.id, super.utilisateurId, super.commentaireId, super.type });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelCommentaireReaction.fromJson(Map<String, dynamic> json) {
    return ModelCommentaireReaction(
      id: json[DatabaseAttributesResources.id],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
      commentaireId: json[DatabaseAttributesResources.commentaireId],
      type: json[DatabaseAttributesResources.type],
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
      DatabaseAttributesResources.type: type,
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
      DatabaseAttributesResources.type: type,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelCommentaireReaction.fromEntity(EntityCommentaireReaction entity) {
    return ModelCommentaireReaction(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      commentaireId: entity.commentaireId,
      type: entity.type,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityCommentaireReaction toEntity() {
    return EntityCommentaireReaction(
      id: id,
      utilisateurId: utilisateurId,
      commentaireId: commentaireId,
      type: type,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelCommentaireReaction copyWith(
    { int? id, int? utilisateurId, int? commentaireId, String? type }
  ) {
    return ModelCommentaireReaction(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      commentaireId: commentaireId ?? this.commentaireId,
      type: type ?? this.type,
    );
  }
}
