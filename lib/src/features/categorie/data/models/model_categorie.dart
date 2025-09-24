import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_categorie.dart';

/// A class that extends [EntityCategorie] and overrides the [toJson] and [copyWith] methods
class ModelCategorie extends EntityCategorie {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelCategorie({ super.id, super.nomCategorie });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelCategorie.fromJson(Map<String, dynamic> json) {
    return ModelCategorie(
      id: json[DatabaseAttributesResources.id],
      nomCategorie: json[DatabaseAttributesResources.nomCategorie],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.nomCategorie: nomCategorie,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.nomCategorie: nomCategorie,
    };
  }

  /// A factory method that creates a new instance of the model from an [EntityCategorie]
  /// 
  /// It takes an [EntityCategorie] and returns a new instance of the model
  factory ModelCategorie.fromEntity(EntityCategorie entity) {
    return ModelCategorie(
      id: entity.id,
      nomCategorie: entity.nomCategorie,
    );
  }

  /// A method that returns a new instance of [EntityCategorie] from the model
  /// 
  /// It takes the model and returns a new instance of [EntityCategorie]
  EntityCategorie toEntity() {
    return EntityCategorie(
      id: id,
      nomCategorie: nomCategorie,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelCategorie copyWith(
    { int? id, String? nomCategorie }
  ) {
    return ModelCategorie(
      id: id ?? this.id,
      nomCategorie: nomCategorie ?? this.nomCategorie,
    );
  }
}
