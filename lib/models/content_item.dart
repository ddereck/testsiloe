import 'package:siloe/src/core/enums/content_type.dart';

class ContentItem {
  final String title;
  final String preacher;
  final String imagePath;
  final String audioUrl;
  final String duration;
  final ContentType type;
  final String date;

  ContentItem({
    required this.title,
    required this.preacher,
    required this.imagePath,
    required this.audioUrl,
    required this.duration,
    required this.type,
    required this.date,
  });
}
