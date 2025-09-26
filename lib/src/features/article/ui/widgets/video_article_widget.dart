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
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/features/article/adapters/article_datas.dart';
import 'package:siloe/src/features/user/domain/enums/user_role_enums.dart';

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
                      borderRadius:
                          BorderRadius.circular(0), // No radius for video
                      child: player,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullscreenVideoPage(
                              controller: ytController,
                            ),
                          ),
                        );
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.publication.titre ?? 'Sans titre',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(() {
                      final user =
                          ControllersProvider.USER_CONTROLLER.user.value;
                      final canEdit = user?.roles.any((r) =>
                              r.toUserRole().isAdminOrReverendOrEditeur) ??
                          false;
                      if (canEdit) {
                        return IconButton(
                          onPressed: () {
                            RoutesUtils.changePage(
                              AppRoutes.updateArticle,
                              arguments: {
                                ArticleDatas.articleArg: widget.publication
                              },
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.grey),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
                const SizedBox(height: 8),
                if (widget.publication.sousTitre != null)
                  Text(
                    widget.publication.sousTitre!,
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