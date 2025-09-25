import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../di/di_helper.dart' show DiHelper;
import '../../../../publication/domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../adapters/commentaire_ui_controller.dart'
    show CommentaireUIController;
import 'comment_item_widget.dart' show CommentItemWidget;

class ListCommentsWidget extends StatelessWidget {
  final EntityPublication publication;
  const ListCommentsWidget({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    if (publication.id == null) {
      return const SizedBox.shrink();
    }
    final commentUiController =
        DiHelper.findOrCreate(creator: () => CommentaireUIController())
          ..initComments(publicationId: publication.id!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Obx(() {
        if (commentUiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${commentUiController.comments.value.length} COMMENTAIRE(S)",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            if (commentUiController.comments.value.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text("Aucun commentaire pour le moment."),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commentUiController.comments.value.length,
                itemBuilder: (context, index) {
                  final comment = commentUiController.comments.value[index];
                  return CommentItemWidget(comment: comment);
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
          ],
        );
      }),
    );
  }
}