class AudioDetail {
  final String title;
  final String speaker;
  final String imagePath;
  final Duration currentTime;
  final Duration totalTime;
  final List<Comment> comments;

  AudioDetail({
    required this.title,
    required this.speaker,
    required this.imagePath,
    required this.currentTime,
    required this.totalTime,
    required this.comments,
  });
}

class Comment {
  final String name;
  final String text;
  final String timeAgo;
  final String? avatarPath;

  Comment({
    required this.name,
    required this.text,
    required this.timeAgo,
    this.avatarPath,
  });
}
