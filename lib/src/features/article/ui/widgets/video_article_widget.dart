import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/enums/content_type.dart' show ContentType;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/text_config.dart' show TextConfig;
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
        DiHelper.findOrCreate(creator: () => ArticleDetailsUIController());
  }

  @override
  void dispose() {
    // Restore portrait orientation when the widget is disposed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ytController = controller.youtubeController.value;

      if (ytController == null) {
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            color: Colors.white,
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.publication.img ?? ""),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
          ),
          child: const Icon(Icons.video_file_rounded),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstantsUtils.containerHPadding,
          vertical: AppConstantsUtils.containerVPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                YoutubePlayer(
                  controller: ytController,
                  showVideoProgressIndicator: true,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.fullscreen, color: Colors.white),
                    onPressed: () {
                      final wasPlaying = ytController.value.isPlaying;
                      if (wasPlaying) {
                        ytController.pause();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullscreenVideoPage(controller: ytController),
                        ),
                      ).then((_) {
                        if (wasPlaying) {
                          ytController.play();
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (widget.publication.titre != null)
              Text(
                widget.publication.titre!,
                style: TextConfig.getSimpleTextStyle(true),
              ),
            if (widget.publication.auteur != null)
              Text(
                widget.publication.auteur!,
                style: TextConfig.getSimpleTextStyle(
                  true,
                  color: Colors.grey,
                  size: AppConstantsUtils.smallSize,
                ),
              ),
          ],
        ),
      );
    });
  }
}