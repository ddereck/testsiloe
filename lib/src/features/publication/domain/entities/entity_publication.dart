import 'package:equatable/equatable.dart';
import '../../../categorie/domain/entities/entity_categorie.dart'
    show EntityCategorie;

class EntityPublication extends Equatable {
  final int? id;
  final int? categorieId;
  final int? typePublicationId;
  final String? titre;
  final String? description;
  final String? img;
  final String? file;
  final String? url;
  final String? datePublication;
  final String? auteur;
  final String? duration;
  final String? article;
  final EntityCategorie? categorie; 

  // Const constructor allowing optional named parameters.
  const EntityPublication({
    this.id,
    this.categorieId,
    this.typePublicationId,
    this.titre,
    this.description,
    this.img,
    this.file,
    this.url,
    this.datePublication,
    this.auteur,
    this.duration,
    this.article,
    this.categorie, 
  });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
        id,
        categorieId,
        typePublicationId,
        titre,
        description,
        img,
        file,
        url,
        datePublication,
        auteur,
        duration,
        article,
        categorie, 
      ];
}
