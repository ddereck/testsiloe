import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart'
    show TablerIcons;
import 'package:get/get.dart';

import '../../../../../commons/ui/widgets/text_field_edit_widget.dart'
    show TextFieldEditWidget;
import '../../../../../core/utils/app_constants_utils.dart'
    show AppConstantsUtils;
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
    return Form(
      key: commentUiController.commentFormState,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
          color: Theme.of(context).highlightColor,
        ),
        margin: const EdgeInsets.only(
          bottom: AppConstantsUtils.itemSpacing,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppConstantsUtils.itemSpacing,
          children: [
            Expanded(
              child: TextFieldEditWidget(
                focusNode: commentUiController.commentFocusNode,
                controller: commentUiController.commentController,
                inputColor: Theme.of(context).highlightColor,
                hint: "Ecrivez un commentaire",
                withTitleWhenTexting: false,
                minLines: 1,
                maxLines: 5,
                blocColor: Theme.of(context).highlightColor,
                keyboardType: TextInputType.multiline,
              ),
            ),
            IconButton(
              onPressed: () async {
                if (commentUiController.commentFormState.currentState!
                    .validate()) {
                  await commentUiController.onSubmitComment(publicationId: publication.id!);
                }
              },
              icon: Obx(() {
                if (commentUiController.isSubmitting.value) {
                  return const CircularProgressIndicator.adaptive();
                }
                return const Icon(TablerIcons.send);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
