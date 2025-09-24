import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:siloe/src/core/configs/time_config.dart';

import '../../../../../core/utils/app_constants_utils.dart'
    show AppConstantsUtils;
import '../../../domain/entities/entity_commentaire.dart'
    show EntityCommentaire;

class CommentItemWidget extends StatelessWidget {
  final EntityCommentaire comment;
  const CommentItemWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    if (comment.contenu == null) {
      return const SizedBox.shrink();
    }
    return Row(
      spacing: AppConstantsUtils.itemSpacingDualSide,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: comment.photo == null
              ? null
              : CachedNetworkImageProvider(comment.photo ?? ""),
          child: comment.photo == null
              ? const Icon(Icons.person, color: Colors.white70)
              : null,
          backgroundColor: const Color(0xFFBDBDBD),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: AppConstantsUtils.itemSpacing,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    comment.nom ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )),
                  if (comment.createdAt != null) ...[
                    Text(
                      TimeConfig.parseAnyDateFormatted(comment.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                comment.contenu ?? "",
                style: const TextStyle(fontSize: 13.5, color: Colors.black87),
              ),
            ],
          ),
        )
      ],
    );
  }
}
