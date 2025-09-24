import 'package:equatable/equatable.dart';

class EntityEvenementInscription extends Equatable {
  final int? id;
  final int? utilisateurId;
  final int? evenementId;
  final String? statut;
  final String? commentaire;
  final String? dateInscription;

  // Const constructor allowing optional named parameters.
  const EntityEvenementInscription({ this.id, this.utilisateurId, this.evenementId, this.statut, this.commentaire, this.dateInscription });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    evenementId,
    statut,
    commentaire,
    dateInscription
  ];
}
