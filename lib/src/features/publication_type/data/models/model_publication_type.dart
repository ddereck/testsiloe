import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_publication_type.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelPublicationType extends EntityPublicationType {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelPublicationType({ super.id, super.typePublication });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelPublicationType.fromJson(Map<String, dynamic> json) {
    return ModelPublicationType(
      id: json[DatabaseAttributesResources.id],
      typePublication: json[DatabaseAttributesResources.typePublication],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.typePublication: typePublication,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.typePublication: typePublication,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelPublicationType.fromEntity(EntityPublicationType entity) {
    return ModelPublicationType(
      id: entity.id,
      typePublication: entity.typePublication,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityPublicationType toEntity() {
    return EntityPublicationType(
      id: id,
      typePublication: typePublication,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelPublicationType copyWith(
    { int? id, String? typePublication }
  ) {
    return ModelPublicationType(
      id: id ?? this.id,
      typePublication: typePublication ?? this.typePublication,
    );
  }
}
