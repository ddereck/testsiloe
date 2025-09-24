import 'package:equatable/equatable.dart';

class EntityCategorie extends Equatable {
  final int? id;
  final String? nomCategorie;

  const EntityCategorie({ this.id, this.nomCategorie });

  factory EntityCategorie.fromJson(Map<String, dynamic> json) {
    return EntityCategorie(
      id: _toInt(json['id']),
      nomCategorie: json['nom_categorie']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom_categorie': nomCategorie,
    };
  }

  @override
  List<Object?> get props => [id, nomCategorie];
}
/// Helper: convertit string|int|null en int?
int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}