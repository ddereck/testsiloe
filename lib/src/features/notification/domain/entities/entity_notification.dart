import 'package:equatable/equatable.dart';

class EntityNotification extends Equatable {
  final int? id;
  final int? utilisateurId;
  final String? titre;
  final String? message;
  final String? type;
  final String? statut;
  final List? data;
  final String? luAt;
  final String? envoyeAt;

  // Const constructor allowing optional named parameters.
  const EntityNotification({ this.id, this.utilisateurId, this.titre, this.message, this.type, this.statut, this.data, this.luAt, this.envoyeAt });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    titre,
    message,
    type,
    statut,
    data,
    luAt,
    envoyeAt
  ];
}
