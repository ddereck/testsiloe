import 'package:equatable/equatable.dart';

class EntityProgramme extends Equatable {
  final int? id;
  final int? utilisateurId;
  final String? date;
  final String? heure;
  final String? type;
  final String? description;
  final String? statut;

  // Const constructor allowing optional named parameters.
  const EntityProgramme({ this.id, this.utilisateurId, this.date, this.heure, this.type, this.description, this.statut });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    date,
    heure,
    type,
    description,
    statut
  ];
}
