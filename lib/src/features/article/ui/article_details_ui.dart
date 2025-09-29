import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/features/home/adapters/home_ui_controller.dart';
import 'package:siloe/src/features/home/ui/widgets/floatting_bottom_nav.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';

import '../../../core/enums/content_type.dart' show ContentType;
import '../../../di/di_helper.dart' show DiHelper;
import '../../authentication/presentation/adapters/auth_ui_controller.dart'
    show AuthUIController;
import '../../commentaire/presentation/adapters/commentaire_ui_controller.dart'
    show CommentaireUIController;
import '../../commentaire/presentation/ui/widgets/add_comment_form_widget.dart'
    show AddCommentFormWidget;
import '../../commentaire/presentation/ui/widgets/list_comments_widget.dart'
    show ListCommentsWidget;
import '../adapters/article_details_ui_controller.dart'
    show ArticleDetailsUIController;
import 'widgets/audio_article_widget.dart' show AudioArticleWidget;
import 'widgets/text_article_widget.dart';
import 'widgets/video_article_widget.dart';

class ArticleDetailsUI extends StatelessWidget {
  const ArticleDetailsUI({super.key});

  @override
  Widget build(BuildContext context) {
    final authUiController = DiHelper.findOrCreate(
      creator: () => AuthUIController(),
    );
    final controller =
        DiHelper.findOrCreate(creator: () => ArticleDetailsUIController())
          ..initArticleByArgs();
    final commentUiController =
        DiHelper.findOrCreate(creator: () => CommentaireUIController());
    final homeUiController =
        DiHelper.findOrCreate(creator: () => HomeUIController());

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (commentUiController.isEmojisVisible.value) {
          commentUiController.toggleEmojisVisibility();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                TopbarWidget(title: "ACCUEIL"),
                Expanded(
                  child: Obx(() {
                    final article = controller.article.value;
                    final contentType = controller.currentContentType.value;
                    if (article == null || contentType == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: Column(
                          children: [
                            if (contentType == ContentType.text) ...[
                              TextArticleWidget(publication: article),
                            ] else if (contentType == ContentType.video) ...[
                              VideoArticleWidget(publication: article),
                            ] else ...[
                              AudioArticleWidget(publication: article),
                            ],
                            // Commentaire
                            Obx(() {
                              if (authUiController.isCurrentlyLogin.value) {
                                return AddCommentFormWidget(
                                  publication: article,
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                            ListCommentsWidget(publication: article),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
            Obx(
              () => FloatingBottomNav(
                selectedIndex: homeUiController.tabIndex.value,
                onItemTapped: (index) {
                  Get.back();
                  homeUiController.changeTabIndex(index);
                },
              ),
            ),
          ],
        ),
      ).emptyScaffold,
    );
  }
}