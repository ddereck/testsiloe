import 'package:flutter/material.dart';

enum ContentType {
  video( label: 'Vidéo', icon: Icons.videocam, color: Colors.red ),
  audio( label: 'Audio', icon: Icons.headphones, color: Colors.blue ),
  text( label: 'Article', icon: Icons.article, color: Colors.green );

  final String label;
  final IconData icon;
  final Color color;

  const ContentType({ required this.label, required this.icon, required this.color });

  static ContentType fromString(String value) {
    switch (value) {
      case 'Video':
        return ContentType.video;
      case 'Audio':
        return ContentType.audio;
      case 'Article':
        return ContentType.text;
      default:
        return ContentType.text;
    }
  }
}
