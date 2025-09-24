import 'package:siloe/src/utils/app_strings.dart';

class EntityDemandeRencontre {
  final int id;
  final int utilisateurId;
  final String nomPrenoms;
  final String email;
  final String telephone;
  final String date;
  final String objet;
  final String statut;
  final String? createdAt;

  const EntityDemandeRencontre({
    required this.id,
    required this.utilisateurId,
    required this.nomPrenoms,
    required this.email,
    required this.telephone,
    required this.date,
    required this.objet,
    required this.statut,
    this.createdAt,
  });

  EntityDemandeRencontre copyWith({
    int? id,
    int? utilisateurId,
    String? nomPrenoms,
    String? email,
    String? telephone,
    String? date,
    String? objet,
    String? statut,
    String? createdAt,
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
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory EntityDemandeRencontre.fromJson(Map<String, dynamic> json) {
    return EntityDemandeRencontre(
      id: json['id'],
      utilisateurId: json['utilisateur_id'],
      nomPrenoms: json['nom_prenoms'],
      email: json['email'],
      telephone: json['telephone'],
      date: json['date'],
      objet: json['objet'],
      statut: json['statut'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'utilisateur_id': utilisateurId,
      'nom_prenoms': nomPrenoms,
      'email': email,
      'telephone': telephone,
      'date': date,
      'objet': objet,
      'statut': statut,
      'created_at': createdAt,
    };
  }

  String getStatutLabel() {
    switch (statut) {
      case 'confirmé':
        return 'Confirmé';
      case 'annulé':
        return 'Annulé';
      case 'en attente':
      default:
        return 'En attente';
    }
  }
}

class RdvDatas {
  static List<EntityDemandeRencontre> generateFakeDemandeRencontres() {
    final now = DateTime.now();
    return List.generate(20, (index) {
      final date = now.subtract(Duration(days: index * 2));
      return EntityDemandeRencontre(
        id: index + 1,
        utilisateurId: 1000 + index,
        nomPrenoms: 'Jean Marc AKAKPO ${index + 1}',
        email: 'jeanmarc${index + 1}@example.com',
        telephone: '+229 01 67 36 ${70 + index}',
        date: _formatDate(date),
        objet: List.generate(5, (_) => AppStrings.lorem).join(' '),
        statut: index % 3 == 0 ? 'confirmé' : (index % 2 == 0 ? 'annulé' : 'en attente'),
        createdAt: date.toIso8601String(),
      );
    });
  }

  static String _formatDate(DateTime date) {
    return '${_weekday(date.weekday)}, ${date.day.toString().padLeft(2, '0')} ${_month(date.month)}.${date.year}';
  }

  static String _weekday(int weekday) {
    const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    return days[(weekday - 1) % 7];
  }

  static String _month(int month) {
    const months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return months[(month - 1) % 12];
  }

  static const String rdvRequestArg = "rdvRequestArg";
}
