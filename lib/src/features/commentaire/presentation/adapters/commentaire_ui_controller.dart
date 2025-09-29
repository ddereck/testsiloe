import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/core/logs/custom_logger.dart';

import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../domain/entities/entity_commentaire.dart' show EntityCommentaire;

class CommentaireUIController extends GetxController {
  Rx<List<EntityCommentaire>> comments = Rx<List<EntityCommentaire>>([]);
  void setComments(List<EntityCommentaire> comments) {
    this.comments.value = comments;
  }

  void initComments({required int publicationId}) async {
    final result = await ControllersProvider.COMMENTAIRE_CONTROLLER
        .getCommentaires(publicationId: publicationId);
    setComments(result);
  }

  var isEmojisVisible = false.obs;
  void toggleEmojisVisibility() {
    isEmojisVisible.value = !isEmojisVisible.value;
    update();
  }

  final commentFormState = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    commentFocusNode.addListener(() {
      if (commentFocusNode.hasFocus) {
        isEmojisVisible.value = false;
        update();
      }
    });
  }

  Rx<bool> isSubmitting = false.obs;
  Future<void> onSubmitComment({required int publicationId}) async {
    if (commentController.text.isEmpty) {
      commentFocusNode.unfocus();
      AppLogger.instance.logger.i("Comment is empty");
      return;
    }
    isSubmitting.value = true;
    update();

    final userName = ControllersProvider.USER_CONTROLLER.user.value?.name ?? "Anonyme";
    await ControllersProvider.COMMENTAIRE_CONTROLLER
        .createCommentaire(contenu: commentController.text, publicationId: publicationId, nom: userName);
    isSubmitting.value = false;
    update();

    commentController.clear();
    commentFocusNode.unfocus();

    initComments(publicationId: publicationId);
  }

  @override
  void onClose() {
    commentController.dispose();
    commentFocusNode.dispose();
    super.onClose();
  }
}
