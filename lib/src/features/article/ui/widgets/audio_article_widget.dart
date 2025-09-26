import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/features/article/adapters/article_datas.dart';
import 'package:siloe/src/features/user/domain/enums/user_role_enums.dart';

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
    final String imageUrl =
        publication.img != null && publication.img!.isNotEmpty
            ? 'https://mobile.lereservoirdesiloe.com${publication.img}'
            : ''; // ou une image par défaut
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (publication.titre != null)
                    Text(
                      publication.titre!,
                      style: TextConfig.getSimpleTextStyle(true,
                          fontWeight: FontWeight.bold, size: 18),
                    ),
                  const SizedBox(height: 4),
                  if (publication.auteur != null)
                    Text(
                      publication.auteur!,
                      style: TextConfig.getSimpleTextStyle(false,
                          color: Colors.grey, size: 14),
                    ),
                ],
              ),
            ),
            Obx(() {
              final user = ControllersProvider.USER_CONTROLLER.user.value;
              final canEdit = user?.roles.any(
                      (r) => r.toUserRole().isAdminOrReverendOrEditeur) ??
                  false;
              if (canEdit) {
                return IconButton(
                  onPressed: () {
                    RoutesUtils.changePage(
                      AppRoutes.updateArticle,
                      arguments: {ArticleDatas.articleArg: publication},
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.grey),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          final position = controller.audioPosition.value;
          final duration = controller.audioDuration.value;
          final buffered = controller.bufferedPosition.value;
          return ProgressBar(
            progress: position,
            buffered: buffered,
            total: duration == Duration.zero
                ? const Duration(seconds: 1)
                : duration,
            baseBarColor: Colors.grey,
            progressBarColor: Colors.red,
            bufferedBarColor: Colors.red.shade300,
            onSeek: (newPosition) {
              controller.audioPlayer.seek(newPosition);
            },
          );
        }),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(TablerIcons.volume, color: Colors.red),
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
                          onChanged: controller.audioPlayer.setVolume,
                        );
                      },
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(TablerIcons.circle_chevron_left,
                  color: Colors.red, size: 40),
              onPressed: controller.reculer10Secondes,
            ),
            Obx(() {
              return CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: IconButton(
                  icon: Icon(
                    controller.isPlaying.value
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  onPressed: controller.togglePlayPause,
                ),
              );
            }),
            IconButton(
              icon: const Icon(TablerIcons.circle_chevron_right,
                  color: Colors.red, size: 40),
              onPressed: controller.avancer10Secondes,
            ),
            IconButton(
              icon: const Icon(TablerIcons.share_2, color: Colors.red),
              onPressed: () {
                final shareUrl = publication.url;
                if (shareUrl != null && shareUrl.isNotEmpty) {
                  SharePlus.instance.share(
                    ShareParams(uri: Uri.parse(shareUrl)),
                  );
                }
              },
            ),
          ],
        ),
      ],
    ).paddingSymmetric(
        horizontal: AppConstantsUtils.containerHPadding,
        vertical: AppConstantsUtils.containerVPadding);
  }
}