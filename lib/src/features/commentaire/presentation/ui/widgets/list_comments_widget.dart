import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_constants_utils.dart'
    show AppConstantsUtils;
import '../../../../../di/di_helper.dart' show DiHelper;
import '../../../../../utils/text_config.dart' show TextConfig;
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
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // Titre section + divider
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        "${commentUiController.comments.value.length} COMMENTAIRE(S)",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black87,
                          letterSpacing: 0.5,
                        ),
                      )),
                  const SizedBox(height: 8),
                  Container(height: 1, color: Colors.black12),
                ],
              ).paddingSymmetric(
                  horizontal: AppConstantsUtils.scaffoldHPadding,
                  vertical: AppConstantsUtils.itemSpacing),
            ),

            Obx(() {
              if (commentUiController.comments.value.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                          child: Text('Aucun commentaire pour le moment',
                              style: TextConfig.getSimpleTextStyle(true)))
                      .paddingSymmetric(
                          vertical: AppConstantsUtils.scaffoldVPadding),
                );
              }
              return SliverList.builder(
                itemCount: commentUiController.comments.value.length,
                itemBuilder: (context, index) {
                  final comment = commentUiController.comments.value[index];
                  return Column(
                    children: [
                      CommentItemWidget(comment: comment).paddingSymmetric(
                          horizontal: AppConstantsUtils.scaffoldHPadding,
                          vertical: AppConstantsUtils.containerVPadding / 2),
                      Container(height: 1, color: Colors.black12)
                          .paddingSymmetric(
                              horizontal: AppConstantsUtils.scaffoldHPadding),
                    ],
                  );
                },
              );
            }),

            // Espace pour la zone de saisie
            SliverToBoxAdapter(
              child:
                  SizedBox(height: 90 + MediaQuery.of(context).padding.bottom),
            ),
          ],
        ),

        // Zone de saisie en bas
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   child: SafeArea(
        //     top: false,
        //     child: Padding(
        //       padding: EdgeInsets.fromLTRB(
        //         AppConstantsUtils.scaffoldHPadding,
        //         8,
        //         AppConstantsUtils.scaffoldHPadding,
        //         12,
        //       ),
        //       //child: _CommentInput(),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// class _CommentInput extends StatefulWidget {
//   @override
//   State<_CommentInput> createState() => _CommentInputState();
// }

// class _CommentInputState extends State<_CommentInput> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Color(0xFFF3F3F3),
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             child: Row(
//               children: [
//                 const Icon(Icons.edit, size: 18, color: Colors.black45),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       isDense: true,
//                       hintText: 'Ecrire  un commentaire',
//                       border: InputBorder.none,
//                     ),
//                     minLines: 1,
//                     maxLines: 3,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.emoji_emotions_outlined,
//                       color: Colors.black45),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Material(
//           color: const Color(0xFF861E0C),
//           borderRadius: BorderRadius.circular(12),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () {/* TODO: submit comment */},
//             child: const Padding(
//               padding: EdgeInsets.all(10),
//               child: Icon(Icons.send, color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
