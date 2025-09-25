import 'package:equatable/equatable.dart';

class EntityEvenement extends Equatable {
  final int? id;
  final int? categorieId;
  final int? typePublicationId;
  final String? theme;
  final String? texteArticle;
  final String? imageDeCouverture;
  final String? dateEvenement;
  final String? dateFin;
  final String? lieu;
  final int? placesLimitees;
  final String? statut;
  final int? utilisateurId;

  // Const constructor allowing optional named parameters.
  const EntityEvenement({ this.id, this.categorieId, this.typePublicationId, this.theme, this.texteArticle, this.imageDeCouverture, this.dateEvenement, this.dateFin, this.lieu, this.placesLimitees, this.statut, this.utilisateurId });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    categorieId,
    typePublicationId,
    theme,
    texteArticle,
    imageDeCouverture,
    dateEvenement,
    dateFin,
    lieu,
    placesLimitees,
    statut,
    utilisateurId
  ];
}
