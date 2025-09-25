import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/enums/content_type.dart' show ContentType;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../publication/domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../adapters/article_details_ui_controller.dart'
    show ArticleDetailsUIController;
import '../pages/fullscreen_video_page.dart';

class VideoArticleWidget extends StatefulWidget {
  final EntityPublication publication;
  const VideoArticleWidget({super.key, required this.publication});

  @override
  State<VideoArticleWidget> createState() => _VideoArticleWidgetState();
}

class _VideoArticleWidgetState extends State<VideoArticleWidget> {
  late ArticleDetailsUIController controller;

  @override
  void initState() {
    super.initState();
    controller =
        DiHelper.findOrCreate(creator: () => ArticleDetailsUIController())
          ..changeContentType(ContentType.video)
          ..initYoutubeVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ytController = controller.youtubeController.value;

      if (ytController == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: ytController,
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: player,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen, color: Colors.white),
                      onPressed: () {
                        if (ytController != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullscreenVideoPage(
                                controller: ytController,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.publication.titre ?? 'Sans titre',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (widget.publication.description != null)
                  Text(
                    widget.publication.description!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}