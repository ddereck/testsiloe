import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_demande_rencontre.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelDemandeRencontre extends EntityDemandeRencontre {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelDemandeRencontre({ super.id, super.utilisateurId, super.nomPrenoms, super.email, super.telephone, super.date, super.objet, super.statut });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelDemandeRencontre.fromJson(Map<String, dynamic> json) {
    return ModelDemandeRencontre(
      id: json[DatabaseAttributesResources.id],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
      nomPrenoms: json[DatabaseAttributesResources.nomPrenoms],
      email: json[DatabaseAttributesResources.email],
      telephone: json[DatabaseAttributesResources.telephone],
      date: json[DatabaseAttributesResources.date],
      objet: json[DatabaseAttributesResources.objet],
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
      DatabaseAttributesResources.nomPrenoms: nomPrenoms,
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.telephone: telephone,
      DatabaseAttributesResources.date: date,
      DatabaseAttributesResources.objet: objet,
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
      DatabaseAttributesResources.nomPrenoms: nomPrenoms,
      DatabaseAttributesResources.email: email,
      DatabaseAttributesResources.telephone: telephone,
      DatabaseAttributesResources.date: date,
      DatabaseAttributesResources.objet: objet,
      DatabaseAttributesResources.statut: statut,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelDemandeRencontre.fromEntity(EntityDemandeRencontre entity) {
    return ModelDemandeRencontre(
      id: entity.id,
      utilisateurId: entity.utilisateurId,
      nomPrenoms: entity.nomPrenoms,
      email: entity.email,
      telephone: entity.telephone,
      date: entity.date,
      objet: entity.objet,
      statut: entity.statut,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityDemandeRencontre toEntity() {
    return EntityDemandeRencontre(
      id: id,
      utilisateurId: utilisateurId,
      nomPrenoms: nomPrenoms,
      email: email,
      telephone: telephone,
      date: date,
      objet: objet,
      statut: statut,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelDemandeRencontre copyWith(
    { int? id, int? utilisateurId, String? nomPrenoms, String? email, String? telephone, String? date, String? objet, String? statut }
  ) {
    return ModelDemandeRencontre(
      id: id ?? this.id,
      utilisateurId: utilisateurId ?? this.utilisateurId,
      nomPrenoms: nomPrenoms ?? this.nomPrenoms,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      date: date ?? this.date,
      objet: objet ?? this.objet,
      statut: statut ?? this.statut,
    );
  }
}
