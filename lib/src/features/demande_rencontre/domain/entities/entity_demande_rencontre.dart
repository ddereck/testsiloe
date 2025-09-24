import 'package:equatable/equatable.dart';

class EntityDemandeRencontre extends Equatable {
  final int? id;
  final int? utilisateurId;
  final String? nomPrenoms;
  final String? email;
  final String? telephone;
  final String? date;
  final String? objet;
  final String? statut;

  // Const constructor allowing optional named parameters.
  const EntityDemandeRencontre({ this.id, this.utilisateurId, this.nomPrenoms, this.email, this.telephone, this.date, this.objet, this.statut });

  // Override Equatable's props getter to include the entity's fields.
  @override
  List<Object?> get props => [
    id,
    utilisateurId,
    nomPrenoms,
    email,
    telephone,
    date,
    objet,
    statut
  ];

  EntityDemandeRencontre copyWith({
  int? id,
  int? utilisateurId,
  String? nomPrenoms,
  String? email,
  String? telephone,
  String? date,
  String? objet,
  String? statut,
}) {
  return EntityDemandeRencontre(
    id: id ?? this.id,
    utilisateurId: utilisateurId ?? this.utilisateurId,
    nomPrenoms: nomPrenoms ?? this.nomPrenoms,
    email: email ?? this.email,
    telephone: telephone ?? this.telephone,
    date: date ?? this.date,
    objet: objet ?? this.objet,
    statut: statut ?? this.statut,
  );
}

}
