import 'package:equatable/equatable.dart';

class EntityCommentaire extends Equatable {
  final int? id;
  final int? utilisateurId;
  final int? publicationId;
  final String? nom;
  final String? photo;
  final String? contenu;
  final int? parentId;
  final String? statut;
  final String? createdAt;

  // Const constructor allowing optional named parameters.
  const EntityCommentaire({ this.id, this.utilisateurId, this.publicationId, this.nom, this.photo, this.contenu, this.parentId, this.statut, this.createdAt});

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    publicationId,
    nom,
    photo,
    contenu,
    parentId,
    statut,
    createdAt,
  ];
}
