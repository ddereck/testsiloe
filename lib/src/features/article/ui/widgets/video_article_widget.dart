import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/enums/content_type.dart' show ContentType;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/text_config.dart' show TextConfig;
import '../../../publication/domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../adapters/article_details_ui_controller.dart'
    show ArticleDetailsUIController;

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
    controller = DiHelper.findOrCreate(creator: () => ArticleDetailsUIController())
      ..changeContentType(ContentType.video)
      ..initYoutubeVideo();
  }

  void toggleFullscreen() {
    final ytController = controller.youtubeController.value;
    if (ytController == null) return;

    final wasPlaying = ytController.value.isPlaying;

    // Si la vidéo est en train de jouer, la mettre en pause
    // if (ytController.value.isPlaying) {
    //   ytController.pause();
    // }


    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: YoutubePlayer(controller: ytController),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((_) {
    //À la sortie du fullscreen, si la vidéo était en cours avant, relancer si tu veux
    if (wasPlaying) {
      ytController.play();
    }
  });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }


  @override
  void dispose() {
    // Toujours restaurer l’état normal en quittant le widget
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ytController = controller.youtubeController.value;
      final videoUrl = controller.videoUrl.value;
      final isFullscreen = controller.isFullscreen.value;

      if (ytController == null || videoUrl == null) {
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
              onError: (exception, stackTrace) => const Icon(Icons.broken_image),
            ),
          ),
          child: const Icon(Icons.video_file_rounded),
        );
      }

      final playerWidget = YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: ytController,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) {
          return Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
                  child: player,
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: toggleFullscreen,
                  icon: Icon(
                    isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  ),
                  label: Text(
                    isFullscreen ? "Quitter le plein écran" : "Plein écran",
                  ),
                ),
              ),
            ],
          );
        },
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          playerWidget,
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
      ).paddingSymmetric(
        horizontal: AppConstantsUtils.containerHPadding,
        vertical: AppConstantsUtils.containerVPadding,
      );
    });
  }
}
