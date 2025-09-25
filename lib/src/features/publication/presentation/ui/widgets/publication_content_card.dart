import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/core/configs/time_config.dart';
import 'package:siloe/src/core/enums/content_type.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/features/user/domain/enums/user_role_enums.dart';
import 'package:siloe/src/utils/image_utils.dart' show ImageUtils;
import '../../../domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../../../article/adapters/article_datas.dart';

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
  ContentType? _contentType;

  @override
  void initState() {
    super.initState();
    _loadContentType();
  }

  Future<void> _loadContentType() async {
    if (widget.publication.typePublicationId == null) return;

    final type = await ControllersProvider.PUBLICATION_TYPE_CONTROLLER
        .getPublicationTypeById(id: widget.publication.typePublicationId!);

    if (type?.typePublication == null) return;

    if (!mounted) return;
    setState(() {
      _contentType = ContentType.fromString(type!.typePublication!);
    });
  }

  void _onUpdate() {
    RoutesUtils.changePage(
      AppRoutes.updateArticle,
      arguments: {ArticleDatas.articleArg: widget.publication},
    );
  }

  IconData _getIconForType(ContentType? type) {
    switch (type) {
      case ContentType.verset:
        return TablerIcons.book;
      case ContentType.temoignage:
        return TablerIcons.cross;
      default:
        return TablerIcons.article;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasMedia = widget.publication.url != null &&
        widget.publication.url!.isNotEmpty &&
        (_contentType == ContentType.audio ||
            _contentType == ContentType.video);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                if (_contentType != null)
                  Icon(
                    _getIconForType(_contentType),
                    size: 24,
                    color: Colors.grey[700],
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _contentType?.label ?? 'Publication',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        TimeConfig.formatDateFr(widget.publication.datePublication),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  final userRoles = ControllersProvider
                          .USER_CONTROLLER.user.value?.roles ??
                      [];
                  final isAdminOrReverendOrEditeur = userRoles
                      .any((r) => r.toUserRole().isAdminOrReverendOrEditeur);
                  if (isAdminOrReverendOrEditeur) {
                    return InkWell(
                      onTap: _onUpdate,
                      child: const Icon(Icons.edit, color: Colors.grey),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              widget.publication.titre ?? 'Sans titre',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          if (widget.publication.sousTitre != null &&
              widget.publication.sousTitre!.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                widget.publication.sousTitre!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ),
          if (widget.publication.img != null &&
              widget.publication.img!.isNotEmpty)
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 220,
                      imageUrl:
                          ImageUtils.buildImageUrl(widget.publication.img),
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[200]),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image, size: 40),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (hasMedia)
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _contentType == ContentType.video
                          ? Icons.play_arrow
                          : Icons.volume_up,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}