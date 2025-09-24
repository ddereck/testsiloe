import 'package:flutter/material.dart';

enum TypeContenu { video, audio, article }

class ContenuCarte extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final TypeContenu type;
  final String date;
  final String imageContenu;

  const ContenuCarte({
    super.key,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.type,
    required this.date,
    required this.imageContenu,
  });

  /// Fonction pour obtenir une icône selon le type de contenu
  IconData getContentIcon() {
    switch (type) {
      case TypeContenu.video:
        return Icons.videocam;
      case TypeContenu.audio:
        return Icons.headphones;
      case TypeContenu.article:
        return Icons.article;
    }
  }

  /// Fonction pour obtenir une couleur selon le type
  Color getContentColor() {
    switch (type) {
      case TypeContenu.video:
        return Colors.red;
      case TypeContenu.audio:
        return Colors.blue;
      case TypeContenu.article:
        return Colors.green;
    }
  }

  /// Texte lisible pour l’utilisateur
  String getContentLabel() {
    switch (type) {
      case TypeContenu.video:
        return 'Video';
      case TypeContenu.audio:
        return 'Audio';
      case TypeContenu.article:
        return 'Article';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageContenu, fit: BoxFit.cover),
        ListTile(
          leading: const Icon(Icons.church),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('$subtitle • $date'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(duration, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(getContentIcon(), size: 16, color: getContentColor()),
                  const SizedBox(width: 4),
                  Text(
                    getContentLabel(),
                    style: TextStyle(
                      fontSize: 12,
                      color: getContentColor(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
