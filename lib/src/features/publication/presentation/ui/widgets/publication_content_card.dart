import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/core/configs/time_config.dart';
import 'package:siloe/src/core/enums/content_type.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/utils/image_utils.dart' show ImageUtils;
import '../../../domain/entities/entity_publication.dart'
    show EntityPublication;

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
    if (mounted) {
      setState(() {
        _contentType = ContentType.fromString(type!.typePublication!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasMedia = widget.publication.url != null &&
        widget.publication.url!.isNotEmpty &&
        (_contentType == ContentType.audio ||
            _contentType == ContentType.video);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 220,
                  imageUrl: ImageUtils.buildImageUrl(widget.publication.img),
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/default.png',
                    fit: BoxFit.cover,
                    height: 220,
                    width: double.infinity,
                  ),
                  fit: BoxFit.cover,
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
          // Content Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(TablerIcons.cross, color: Colors.black, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author
                      Text(
                        widget.publication.auteur ?? 'Auteur inconnu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Category and Date
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${widget.publication.categorie?.nomCategorie ?? 'Catégorie'}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  ' • ${TimeConfig.formatDateFr(widget.publication.datePublication)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Description Snippet
                      Text(
                        widget.publication.description ??
                            widget.publication.titre ??
                            'Aucune description',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}