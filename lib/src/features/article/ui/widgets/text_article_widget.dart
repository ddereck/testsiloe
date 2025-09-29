import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/features/article/adapters/article_datas.dart';
import 'package:siloe/src/features/user/domain/enums/user_role_enums.dart';
import 'package:siloe/src/utils/image_utils.dart';
import '../../../../core/enums/content_type.dart';
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/text_config.dart' show TextConfig;
import '../../../publication/domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../adapters/article_details_ui_controller.dart';

class TextArticleWidget extends StatelessWidget {
  final EntityPublication publication;
  const TextArticleWidget({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    DiHelper.findOrCreate(creator: () => ArticleDetailsUIController())
        .changeContentType(ContentType.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (publication.img != null && publication.img!.isNotEmpty)
          CachedNetworkImage(
            imageUrl: ImageUtils.buildImageUrl(publication.img),
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/default.png', fit: BoxFit.cover),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (publication.titre != null)
                          Text(
                            publication.titre!,
                            style: TextConfig.getSimpleTextStyle(true,
                                fontWeight: FontWeight.bold, size: 20),
                          ),
                        const SizedBox(height: 4),
                        if (publication.auteur != null)
                          Text(
                            publication.auteur!,
                            style: TextConfig.getSimpleTextStyle(false,
                                color: Colors.grey[600], size: 14),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
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
                                  ArticleDatas.articleArg: publication
                                },
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.grey),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                      IconButton(
                        icon:
                            const Icon(TablerIcons.share, color: Colors.red),
                        onPressed: () {
                          final id = publication.id;
                          if (id != null) {
                            final shareUrl =
                                "https://mobile.lereservoirdesiloe.com/publications/$id";
                            Share.share(
                              "Regarde cet article sur Le Réservoir de Siloe : $shareUrl",
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Lien de partage non disponible")),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (publication.article != null &&
                  publication.article!.isNotEmpty)
                Text(
                  publication.article!,
                  style: TextConfig.getSimpleTextStyle(false, height: 1.5),
                  textAlign: TextAlign.justify,
                )
              else if (publication.description != null)
                Text(
                  publication.description!,
                  style: TextConfig.getSimpleTextStyle(false, height: 1.5),
                  textAlign: TextAlign.justify,
                ),
            ],
          ),
        ),
      ],
    );
  }
}