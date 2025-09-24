import 'package:equatable/equatable.dart';

class EntityCommentaireReaction extends Equatable {
  final int? id;
  final int? utilisateurId;
  final int? commentaireId;
  final String? type;

  // Const constructor allowing optional named parameters.
  const EntityCommentaireReaction({ this.id, this.utilisateurId, this.commentaireId, this.type });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    commentaireId,
    type
  ];
}
