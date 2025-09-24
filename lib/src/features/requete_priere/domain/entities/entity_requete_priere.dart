import 'package:equatable/equatable.dart';

class EntityRequetePriere extends Equatable {
  final int? id;
  final String? nomPrenom;
  final bool? anonyme;
  final String? contenu;
  final String? statut;
  final String? createdAt;
  final String? updatedAt;

  // Const constructor allowing optional named parameters.
  const EntityRequetePriere({ this.id, this.nomPrenom, this.anonyme, this.contenu, this.statut, this.createdAt, this.updatedAt});

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    nomPrenom,
    anonyme,
    contenu,
    statut,
    createdAt,
    updatedAt,
  ];
}
