import 'package:equatable/equatable.dart';

class EntityCommentaireReport extends Equatable {
  final int? id;
  final int? utilisateurId;
  final int? commentaireId;
  final String? raison;

  // Const constructor allowing optional named parameters.
  const EntityCommentaireReport({ this.id, this.utilisateurId, this.commentaireId, this.raison });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    commentaireId,
    raison
  ];
}
