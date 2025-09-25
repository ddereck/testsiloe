import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart'
    show TablerIcons;
import 'package:get/get.dart';

import '../../../../../di/di_helper.dart' show DiHelper;
import '../../../../publication/domain/entities/entity_publication.dart'
    show EntityPublication;
import '../../adapters/commentaire_ui_controller.dart'
    show CommentaireUIController;

class AddCommentFormWidget extends StatelessWidget {
  final EntityPublication publication;
  const AddCommentFormWidget({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    if (publication.id == null) {
      return const SizedBox.shrink();
    }

    final commentUiController =
        DiHelper.findOrCreate(creator: () => CommentaireUIController())
          ..initComments(publicationId: publication.id!);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Form(
        key: commentUiController.commentFormState,
        child: TextFormField(
          controller: commentUiController.commentController,
          focusNode: commentUiController.commentFocusNode,
          decoration: InputDecoration(
            hintText: "Ecrire un commentaire...",
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            suffixIcon: Obx(() {
              if (commentUiController.isSubmitting.value) {
                return const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                );
              }
              return IconButton(
                icon: const Icon(TablerIcons.send),
                onPressed: () async {
                  if (commentUiController.commentFormState.currentState!
                      .validate()) {
                    await commentUiController.onSubmitComment(
                        publicationId: publication.id!);
                  }
                },
              );
            }),
          ),
          minLines: 1,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}