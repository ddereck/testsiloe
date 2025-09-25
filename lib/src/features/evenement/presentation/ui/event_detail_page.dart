import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:siloe/src/features/evenement/domain/entities/evenement.dart';
import 'package:siloe/src/utils/image_utils.dart';
import 'package:intl/intl.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Evenement event = Get.arguments;

    String _formatDate(String? dateStr) {
      if (dateStr == null) return '';
      try {
        final date = DateTime.parse(dateStr);
        return DateFormat('dd MMMM yyyy', 'fr_FR').format(date);
      } catch (e) {
        return '';
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                event.theme ?? 'Détail de l\'événement',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: event.imageDeCouverture != null
                  ? CachedNetworkImage(
                      imageUrl: ImageUtils.buildImageUrl(event.imageDeCouverture),
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey[300]),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(event.dateEvenement),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (event.sousTitre != null)
                    Text(
                      event.sousTitre!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (event.texteArticle != null)
                    Text(
                      event.texteArticle!,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}