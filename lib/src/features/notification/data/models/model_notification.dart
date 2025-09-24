import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_notification.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelNotification extends EntityNotification {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelNotification({ super.id, super.utilisateurId, super.titre, super.message, super.type, super.statut, super.data, super.luAt, super.envoyeAt });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelNotification.fromJson(Map<String, dynamic> json) {
    return ModelNotification(
      id: json[DatabaseAttributesResources.id],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
      titre: json[DatabaseAttributesResources.titre],
      message: json[DatabaseAttributesResources.message],
      type: json[DatabaseAttributesResources.type],
      statut: json[DatabaseAttributesResources.statut],
      data: json[DatabaseAttributesResources.data],
      luAt: json[DatabaseAttributesResources.luAt],
      envoyeAt: json[DatabaseAttributesResources.envoyeAt],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.titre: titre,
      DatabaseAttributesResources.message: message,
      DatabaseAttributesResources.type: type,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.data: data,
      DatabaseAttributesResources.luAt: luAt,
      DatabaseAttributesResources.envoyeAt: envoyeAt,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
      DatabaseAttributesResources.titre: titre,
      DatabaseAttributesResources.message: message,
      DatabaseAttributesResources.type: type,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.data: data,
      DatabaseAttributesResources.luAt: luAt,
      DatabaseAttributesResources.envoyeAt: envoyeAt,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelNotification.fromEntity(EntityNotification entity) {
    return ModelNotification(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      titre: entity.titre,
      message: entity.message,
      type: entity.type,
      statut: entity.statut,
      data: entity.data,
      luAt: entity.luAt,
      envoyeAt: entity.envoyeAt,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityNotification toEntity() {
    return EntityNotification(
      id: id,
      utilisateurId: utilisateurId,
      titre: titre,
      message: message,
      type: type,
      statut: statut,
      data: data,
      luAt: luAt,
      envoyeAt: envoyeAt,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelNotification copyWith(
    { int? id, int? utilisateurId, String? titre, String? message, String? type, String? statut, List? data, String? luAt, String? envoyeAt }
  ) {
    return ModelNotification(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      titre: titre ?? this.titre,
      message: message ?? this.message,
      type: type ?? this.type,
      statut: statut ?? this.statut,
      data: data ?? this.data,
      luAt: luAt ?? this.luAt,
      envoyeAt: envoyeAt ?? this.envoyeAt,
    );
  }
}
