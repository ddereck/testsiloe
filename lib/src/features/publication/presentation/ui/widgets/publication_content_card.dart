import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../core/configs/time_config.dart' show TimeConfig;
import '../../../../../core/enums/content_type.dart';
import '../../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../../core/utils/app_constants_utils.dart'
    show AppConstantsUtils;
import '../../../../../core/utils/routes_utils.dart'
    show RoutesUtils, AppRoutes;
import '../../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../../../../di/di_helper.dart' show DiHelper;
import '../../../../../utils/text_config.dart' show TextConfig;
import '../../../../../utils/image_utils.dart' show ImageUtils;
import '../../../../article/adapters/article_datas.dart' show ArticleDatas;
import '../../../domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../adapters/publication_ui_controller.dart'
    show PublicationsUIController;
  import '../../../../user/domain/enums/user_role_enums.dart' show UserRoleEnumsExtension;


class PublicationContentCard extends StatefulWidget {
  final EntityPublication publication;

  const PublicationContentCard({
    super.key,
    required this.publication,
  });

  @override
  State<PublicationContentCard> createState() => _PublicationContentCardState();
}

class _PublicationContentCardState extends State<PublicationContentCard> {
  final publicationsUiController =
      DiHelper.findOrCreate(creator: () => PublicationsUIController());

  ContentType? _contentType;
  Duration? _mediaDuration;
  //bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _loadContentType();
    _loadMediaDuration();
  }

  /// Chargement sécurisé du type de publication
  Future<void> _loadContentType() async {
    if (widget.publication.typePublicationId == null) return;

    AppLogger.instance.logger.i(
        "widget.publication.typePublicationId: ${widget.publication.typePublicationId}");

    final type = await ControllersProvider.PUBLICATION_TYPE_CONTROLLER
        .getPublicationTypeById(id: widget.publication.typePublicationId!);

    if (widget.publication.id == 8) {
      AppLogger.instance.logger.i("type: $type");
    }

    if (type?.typePublication == null) return;

    if (!mounted) return;
    setState(() {
      _contentType = ContentType.fromString(type!.typePublication!);
    });
  }

  Future<void> _loadMediaDuration() async {
    final url = widget.publication.url;
    if (url == null || url.isEmpty) return;

    if (_contentType == ContentType.video) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await controller.initialize();
      setState(() {
        _mediaDuration = controller.value.duration;
      });
      controller.dispose();
    } else if (_contentType == ContentType.audio) {
      final player = AudioPlayer();
      await player.setUrl(url);
      setState(() {
        _mediaDuration = player.duration;
      });
      await player.dispose();
    }
  }

  /// Suppression sécurisée
  // Future<void> _onDelete() async {
  //   if (widget.publication.id == null) return;

  //   if (!mounted) return;
  //   setState(() => _isDeleting = true);

  //   final success = await publicationsUiController.deletePublication(id: widget.publication.id!);

  //   if (!mounted) return;
  //   if (success) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Publication supprimée avec succès ✅")),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Une erreur est survenue ❌")),
  //     );
  //   }

  //   if (!mounted) return;
  //   setState(() => _isDeleting = false);
  // }

  /// Navigation vers l’update
  void _onUpdate() {
    RoutesUtils.changePage(
      AppRoutes.updateArticle,
      arguments: {ArticleDatas.articleArg: widget.publication},
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 220,
                  imageUrl: ImageUtils.buildImageUrl(widget.publication.img),
                  placeholder: (context, url) => const SizedBox.shrink(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, size: 40),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: Icon(
                  _contentType == ContentType.video
                      ? Icons.video_camera_back
                      : _contentType == ContentType.audio
                          ? TablerIcons.volume
                          : TablerIcons.file_description,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          leading: const Icon(TablerIcons.building_church),
          title: Text(
            widget.publication.titre ?? '-',
            overflow: TextOverflow.ellipsis,
            style: TextConfig.getSimpleTextStyle(
              true,
              size: 10,
            ),
          ),
          subtitle: Text(
            '${widget.publication.categorie?.nomCategorie ?? '-'} • ${TimeConfig.formatDateFr(widget.publication.datePublication)}',
            overflow: TextOverflow.ellipsis,
            style: TextConfig.getSimpleTextStyle(
              false,
              size: 9,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: AppConstantsUtils.itemSpacingSmall,
            children: [
              if (widget.publication.duration != null)
                Text(
                  widget.publication.duration ?? '-',
                  style: TextConfig.getSimpleTextStyle(true),
                ),
              if (_mediaDuration != null)
                Text(
                  _formatDuration(_mediaDuration!),
                  style: TextConfig.getSimpleTextStyle(true, size: 10),
                ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  Obx(() {
                    final userRoles = ControllersProvider.USER_CONTROLLER.user.value?.roles ?? [];
                    final isAdminOrReverendOrEditeur = userRoles.any((r) => r.toUserRole().isAdminOrReverendOrEditeur);
                    if (isAdminOrReverendOrEditeur) {
                      return Row(
                        spacing: 5,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: _onUpdate,
                            child: const Icon(Icons.edit),
                          ),
                          // InkWell(
                          //   onTap: _onDelete,
                          //   child: _isDeleting
                          //       ? const SizedBox(
                          //           width: 20,
                          //           height: 20,
                          //           child:
                          //               CircularProgressIndicator.adaptive(),
                          //         )
                          //       : const Icon(Icons.delete),
                          // ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  if (_contentType?.label != null)
                    Row(
                      children: [
                        Icon(
                          _contentType?.icon,
                          size: 10,
                          color: _contentType?.color,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _contentType?.label ?? '',
                          style: TextStyle(
                            fontSize: 10,
                            color: _contentType?.color,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
