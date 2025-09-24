import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/enums/content_type.dart';
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
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
    final String imageUrl =
        publication.img != null && publication.img!.isNotEmpty
            ? 'https://mobile.lereservoirdesiloe.com${publication.img}'
            : ''; // ou une image par défaut
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstantsUtils.itemSpacing,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstantsUtils.itemSpacing,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          color: Colors.grey,
                          size: AppConstantsUtils.smallSize),
                    ),
                  ],
                ],
              ),
            ),IconButton(
              icon: const Icon(TablerIcons.share, color: Colors.red),
              onPressed: () {
                final id = publication.id;
                debugPrint("publication.id: $id");
                if (id != null) {
                  final shareUrl = "https://mobile.lereservoirdesiloe.com/publications/$id";
                  SharePlus.instance.share(
                    ShareParams(
                      uri: Uri.parse(shareUrl),
                      text: "Regarde cet article sur Le Réservoir de Siloe : $shareUrl",
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lien de partage non disponible")),
                  );
                }
              },
            ),
          ],
        ),
        // Afficher le contenu de l'article s'il existe, sinon la description
        if (publication.article != null && publication.article!.isNotEmpty) ...[
          Text(
            publication.article ?? "",
            style: TextConfig.getSimpleTextStyle(false),
            textAlign: TextAlign.justify, 
          ).paddingSymmetric(
              horizontal: AppConstantsUtils.containerHPadding,
              vertical: AppConstantsUtils.containerVPadding),
        ] else if (publication.description != null) ...[
          Text(
            publication.description ?? "",
            style: TextConfig.getSimpleTextStyle(false),
            textAlign: TextAlign.justify,
          ).paddingSymmetric(
              horizontal: AppConstantsUtils.containerHPadding,
              vertical: AppConstantsUtils.containerVPadding),
        ],

        SizedBox(height: 50),
      ],
    ).paddingSymmetric(
        horizontal: AppConstantsUtils.containerHPadding,
        vertical: AppConstantsUtils.containerVPadding);
  }
}
