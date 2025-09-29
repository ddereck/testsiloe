import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;

import '../../../../core/enums/content_type.dart' show ContentType;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/text_config.dart' show TextConfig;
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
    final String imageUrl = publication.img != null && publication.img!.isNotEmpty
        ? 'https://mobile.lereservoirdesiloe.com${publication.img}'
        : ''; // ou une image par défaut
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstantsUtils.itemSpacingDualSide,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            color: Colors.white,
            image: DecorationImage(
              image: imageUrl.isNotEmpty
                  ? CachedNetworkImageProvider(imageUrl)
                  : const AssetImage('assets/images/default.png')
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
         // child: const Icon(Icons.broken_image),
        ),
        if (publication.titre != null) ...[
          Text(
            publication.titre ?? "",
            style: TextConfig.getSimpleTextStyle(true),
          ),
        ],
        if (publication.auteur != null) ...[
          Text(
            publication.auteur ?? "",
            style: TextConfig.getSimpleTextStyle(true,
                color: Colors.grey, size: AppConstantsUtils.smallSize),
          ),
        ],
        Obx(() {
          final position = controller.audioPosition.value;
          final duration = controller.audioDuration.value;
          // Si tu gères le buffering, remplace par la valeur correcte, sinon Duration.zero
          final buffered = controller.bufferedPosition.value;
          return ProgressBar(
            progress: position,
            buffered: buffered,
            total: duration == Duration.zero ? Duration(seconds: 1) : duration,
            baseBarColor: Colors.grey,
            progressBarColor: Colors.red,
            bufferedBarColor: Colors.red.shade300,
            onSeek: (newPosition) {
              debugPrint('User selected a new time: $newPosition');
              controller.audioPlayer.seek(newPosition);
            },
          ).paddingSymmetric(horizontal: AppConstantsUtils.containerHPadding);
        }),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppConstantsUtils.itemSpacing,
            children: [
              InkWell(
                onTap: () {},
                child: Icon(
                  TablerIcons.volume,
                  color: Colors.red,
                ),
              ),
              InkWell(
                onTap: () {
                  controller.reculer10Secondes();
                },
                child: Icon(
                  TablerIcons.circle_chevron_left,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              Obx(() {
                return InkWell(
                  onTap: () {
                    controller.togglePlayPause();
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
              InkWell(
                onTap: () {
                  controller.avancer10Secondes();
                },
                child: Icon(
                  TablerIcons.circle_chevron_right,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              InkWell(
                onTap: () {
                  // Partager l'URL audio uniquement
                  final shareUrl = publication.url;
                  if (shareUrl != null && shareUrl.isNotEmpty) {
                    SharePlus.instance.share(
                      ShareParams(uri: Uri.parse(shareUrl)),
                    );
                  }
                },
                child: Icon(
                  TablerIcons.share_2,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    ).paddingSymmetric(
        horizontal: AppConstantsUtils.containerHPadding,
        vertical: AppConstantsUtils.containerVPadding);
  }
}
