import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_evenement.dart';

/// A class that extends [Entity] and overrides the [toJson] and [copyWith] methods
class ModelEvenement extends EntityEvenement {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelEvenement({ super.id, super.categorieId, super.typePublicationId, super.theme, super.texteArticle, super.imageDeCouverture, super.dateEvenement, super.dateFin, super.lieu, super.placesLimitees, super.statut, super.utilisateurId });

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelEvenement.fromJson(Map<String, dynamic> json) {
    return ModelEvenement(
      id: json[DatabaseAttributesResources.id],
      categorieId: json[DatabaseAttributesResources.categorieId],
      typePublicationId: json[DatabaseAttributesResources.typePublicationId],
      theme: json[DatabaseAttributesResources.theme],
      texteArticle: json[DatabaseAttributesResources.texteArticle],
      imageDeCouverture: json[DatabaseAttributesResources.imageDeCouverture],
      dateEvenement: json[DatabaseAttributesResources.dateEvenement],
      dateFin: json[DatabaseAttributesResources.dateFin],
      lieu: json[DatabaseAttributesResources.lieu],
      placesLimitees: json[DatabaseAttributesResources.placesLimitees],
      statut: json[DatabaseAttributesResources.statut],
      utilisateurId: json[DatabaseAttributesResources.utilisateurId],
    );
  }

  /// A method that returns a map of the attributes of the model
  /// 
  /// It is used to create a new instance of the model
  Map<String, dynamic> toJson() {
    return {
      DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.categorieId: categorieId,
      DatabaseAttributesResources.typePublicationId: typePublicationId,
      DatabaseAttributesResources.theme: theme,
      DatabaseAttributesResources.texteArticle: texteArticle,
      DatabaseAttributesResources.imageDeCouverture: imageDeCouverture,
      DatabaseAttributesResources.dateEvenement: dateEvenement,
      DatabaseAttributesResources.dateFin: dateFin,
      DatabaseAttributesResources.lieu: lieu,
      DatabaseAttributesResources.placesLimitees: placesLimitees,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
    };
  }

  /// A method that returns a map of the attributes of the model without the id
  /// 
  /// It is used to create a new instance of the model without the id
  Map<String, dynamic> toJsonWithoutId() {
    return {
      // DatabaseAttributesResources.id: id,
      DatabaseAttributesResources.categorieId: categorieId,
      DatabaseAttributesResources.typePublicationId: typePublicationId,
      DatabaseAttributesResources.theme: theme,
      DatabaseAttributesResources.texteArticle: texteArticle,
      DatabaseAttributesResources.imageDeCouverture: imageDeCouverture,
      DatabaseAttributesResources.dateEvenement: dateEvenement,
      DatabaseAttributesResources.dateFin: dateFin,
      DatabaseAttributesResources.lieu: lieu,
      DatabaseAttributesResources.placesLimitees: placesLimitees,
      DatabaseAttributesResources.statut: statut,
      DatabaseAttributesResources.utilisateurId: utilisateurId,
    };
  }

  /// A factory method that creates a new instance of the model from an [Entity]
  /// 
  /// It takes an [Entity] and returns a new instance of the model
  factory ModelEvenement.fromEntity(EntityEvenement entity) {
    return ModelEvenement(
      id: entity.id,
      categorieId: entity.categorieId,
      typePublicationId: entity.typePublicationId,
      theme: entity.theme,
      texteArticle: entity.texteArticle,
      imageDeCouverture: entity.imageDeCouverture,
      dateEvenement: entity.dateEvenement,
      dateFin: entity.dateFin,
      lieu: entity.lieu,
      placesLimitees: entity.placesLimitees,
      statut: entity.statut,
      utilisateurId: entity.utilisateurId,
    );
  }

  /// A method that returns a new instance of [Entity] from the model
  /// 
  /// It takes the model and returns a new instance of [Entity]
  EntityEvenement toEntity() {
    return EntityEvenement(
      id: id,
      categorieId: categorieId,
      typePublicationId: typePublicationId,
      theme: theme,
      texteArticle: texteArticle,
      imageDeCouverture: imageDeCouverture,
      dateEvenement: dateEvenement,
      dateFin: dateFin,
      lieu: lieu,
      placesLimitees: placesLimitees,
      statut: statut,
      utilisateurId: utilisateurId,
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelEvenement copyWith(
    { int? id, int? categorieId, int? typePublicationId, String? theme, String? texteArticle, String? imageDeCouverture, String? dateEvenement, String? dateFin, String? lieu, int? placesLimitees, String? statut, int? utilisateurId }
  ) {
    return ModelEvenement(
      id: id ?? this.id,
      categorieId: categorieId ?? this.categorieId,
      typePublicationId: typePublicationId ?? this.typePublicationId,
      theme: theme ?? this.theme,
      texteArticle: texteArticle ?? this.texteArticle,
      imageDeCouverture: imageDeCouverture ?? this.imageDeCouverture,
      dateEvenement: dateEvenement ?? this.dateEvenement,
      dateFin: dateFin ?? this.dateFin,
      lieu: lieu ?? this.lieu,
      placesLimitees: placesLimitees ?? this.placesLimitees,
      statut: statut ?? this.statut,
      utilisateurId: utilisateurId ?? this.utilisateurId,
    );
  }
}
