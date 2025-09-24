//import 'package:siloe/src/core/logs/custom_logger.dart';

import '../../../../core/resources/database_attributes_resources.dart';

import '../../domain/entities/entity_publication.dart';
import '../../../categorie/domain/entities/entity_categorie.dart' show EntityCategorie;

/// A class that extends [EntityPublication] and overrides the [toJson] and [copyWith] methods
class ModelPublication extends EntityPublication {

  /// The constructor of the model
  /// 
  /// It takes a map of the attributes of the model
  const ModelPublication({ super.id, super.categorieId, super.typePublicationId, super.titre, super.description, 
    super.img, super.file, super.url, super.datePublication, super.auteur, super.duration, super.article, super.categorie});

  /// A factory method that creates a new instance of the model from a map
  /// 
  /// It takes a map of the attributes of the model
  factory ModelPublication.fromJson(Map<String, dynamic> json) {
    ///AppLogger.instance.logger.i("Json: $json");
    return ModelPublication(
      id: _toInt(json[DatabaseAttributesResources.id]),
      categorieId: _toInt(json[DatabaseAttributesResources.categorieId]),
      typePublicationId: _toInt(json[DatabaseAttributesResources.typePublicationId]),
      titre: json[DatabaseAttributesResources.titre]?.toString(),
      description: json[DatabaseAttributesResources.description]?.toString(),
      img: json[DatabaseAttributesResources.img]?.toString(),
      file: json[DatabaseAttributesResources.file]?.toString(),
      url: json[DatabaseAttributesResources.url]?.toString(),
      datePublication: json[DatabaseAttributesResources.datePublication]?.toString(),
      auteur: json[DatabaseAttributesResources.auteur]?.toString(),
      duration: json[DatabaseAttributesResources.duration]?.toString(),
      article: json[DatabaseAttributesResources.article]?.toString(),
      categorie: json['categorie'] != null
          ? EntityCategorie.fromJson(json['categorie'])
          : null,
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
      DatabaseAttributesResources.titre: titre,
      DatabaseAttributesResources.description: description,
      DatabaseAttributesResources.img: img,
      DatabaseAttributesResources.file: file,
      DatabaseAttributesResources.url: url,
      DatabaseAttributesResources.datePublication: datePublication,
      DatabaseAttributesResources.auteur: auteur,
      DatabaseAttributesResources.duration: duration,
      DatabaseAttributesResources.article: article,
      'categorie': categorie?.toJson(), 
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
      DatabaseAttributesResources.titre: titre,
      DatabaseAttributesResources.description: description,
      DatabaseAttributesResources.img: img,
      DatabaseAttributesResources.file: file,
      DatabaseAttributesResources.url: url,
      DatabaseAttributesResources.datePublication: datePublication,
      DatabaseAttributesResources.auteur: auteur,
      DatabaseAttributesResources.duration: duration,
      DatabaseAttributesResources.article: article,
    };
  }

  /// A factory method that creates a new instance of the model from an [EntityPublication]
  /// 
  /// It takes an [EntityPublication] and returns a new instance of the model
  factory ModelPublication.fromEntity(EntityPublication entity) {
    return ModelPublication(
      id: entity.id,
      categorieId: entity.categorieId,
      typePublicationId: entity.typePublicationId,
      titre: entity.titre,
      description: entity.description,
      img: entity.img,
      file: entity.file,
      url: entity.url,
      datePublication: entity.datePublication,
      auteur: entity.auteur,
      duration: entity.duration,
      article: entity.article,
      categorie: entity.categorie, 
    );
  }

  /// A method that returns a new instance of [EntityPublication] from the model
  /// 
  /// It takes the model and returns a new instance of [EntityPublication]
  EntityPublication toEntity() {
    return EntityPublication(
      id: id,
      categorieId: categorieId,
      typePublicationId: typePublicationId,
      titre: titre,
      description: description,
      img: img,
      file: file,
      url: url,
      datePublication: datePublication,
      auteur: auteur,
      duration: duration,
      article: article,
      categorie: categorie, 
    );
  }

  /// A method that returns a new instance of the model with the given attributes
  /// 
  /// It takes a map of the attributes of the model and returns a new instance of the model
  ModelPublication copyWith(
    { int? id, int? categorieId, int? typePublicationId, String? titre, String? description, 
    String? img, String? file, String? url, String? datePublication, String? auteur, String? duration, String? article, EntityCategorie? categorie }
  ) {
    return ModelPublication(
      id: id ?? this.id,
      categorieId: categorieId ?? this.categorieId,
      typePublicationId: typePublicationId ?? this.typePublicationId,
      titre: titre ?? this.titre,
      description: description ?? this.description,
      img: img ?? this.img,
      file: file ?? this.file,
      url: url ?? this.url,
      datePublication: datePublication ?? this.datePublication,
      auteur: auteur ?? this.auteur,
      duration: duration ?? this.duration,
      article: article ?? this.article,
      categorie: categorie ?? this.categorie, 
    );
  }
}

/// Helper: convertit string|int|null en int?
int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}
