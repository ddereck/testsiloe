
import '../../domain/entities/entity_authentication.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelAuthentication extends EntityAuthentication {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelAuthentication();

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelAuthentication.fromJson(Map<String, dynamic> json) {
    return ModelAuthentication(
      
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelAuthentication.fromEntity(EntityAuthentication entity) {
    return ModelAuthentication(
      
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityAuthentication toEntity() {
    return EntityAuthentication(
      
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelAuthentication copyWith(
    
  ) {
    return ModelAuthentication(
      
    );
  }
}
