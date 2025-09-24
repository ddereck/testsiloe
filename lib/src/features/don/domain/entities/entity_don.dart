import 'package:equatable/equatable.dart';

class EntityDon extends Equatable {
  final int? id;
  final int? utilisateurId;
  final String? nomAffiche;
  final int? montant;
  final String? reseau;
  final bool? anonyme;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  // Const constructor allowing optional named parameters.
  const EntityDon({ this.id, this.utilisateurId, this.nomAffiche, this.montant, this.reseau, this.anonyme, this.status, this.createdAt, this.updatedAt });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    nomAffiche,
    montant,
    reseau,
    anonyme,
    status,
    createdAt,
    updatedAt,
  ];
}
