import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart' show Share;
import 'package:siloe/src/utils/image_utils.dart';

import '../../../../core/enums/content_type.dart' show ContentType;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../publication/domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../adapters/article_details_ui_controller.dart'
    show ArticleDetailsUIController;

class AudioArticleWidget extends StatelessWidget {
  final EntityPublication publication;
  const AudioArticleWidget({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => ArticleDetailsUIController())
          ..initArticle(publication)
          ..changeContentType(ContentType.audio)
          ..initAudio();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (publication.img != null)
            CachedNetworkImage(
              imageUrl: ImageUtils.buildImageUrl(publication.img),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  publication.titre ?? "Sans titre",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  publication.auteur ?? "Auteur inconnu",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  return ProgressBar(
                    progress: controller.audioPosition.value,
                    buffered: controller.bufferedPosition.value,
                    total: controller.audioDuration.value,
                    onSeek: controller.audioPlayer.seek,
                    barHeight: 8.0,
                    thumbRadius: 10.0,
                    baseBarColor: Colors.grey.shade300,
                    progressBarColor: const Color(0xFF7A0C0C),
                    bufferedBarColor: const Color(0xFF7A0C0C).withOpacity(0.5),
                    thumbColor: const Color(0xFF7A0C0C),
                    timeLabelTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(TablerIcons.volume),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StreamBuilder<double>(
                              stream: controller.audioPlayer.volumeStream,
                              builder: (context, snapshot) {
                                final volume = snapshot.data ?? 0.5;
                                return Slider(
                                  value: volume,
                                  min: 0.0,
                                  max: 1.0,
                                  onChanged: controller.setVolume,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(TablerIcons.rotate_clockwise_2),
                      iconSize: 32,
                      onPressed: controller.avancer10Secondes,
                    ),
                    Obx(() {
                      return IconButton(
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                        ),
                        iconSize: 64,
                        color: const Color(0xFF7A0C0C),
                        onPressed: controller.togglePlayPause,
                      );
                    }),
                    IconButton(
                      icon: const Icon(TablerIcons.rotate_dot),
                      iconSize: 32,
                      onPressed: controller.reculer10Secondes,
                    ),
                    IconButton(
                      icon: const Icon(TablerIcons.share_2),
                      onPressed: () {
                        if (publication.url != null) {
                          Share.share(publication.url!);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  publication.description ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}