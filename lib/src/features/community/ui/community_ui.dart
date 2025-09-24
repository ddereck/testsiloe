import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/utils/text_config.dart';

import '../../../commons/ui/widgets/text_field_edit_widget.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../di/di_helper.dart' show DiHelper;
import '../../../utils/field_formatter.dart';
import '../adapters/community_ui_controller.dart' show CommunityUIController;

class CommunityUI extends StatelessWidget {
  const CommunityUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => CommunityUIController())
          ..initUers();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(title: "Communauté"),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior
                .opaque, // pour capter les taps même sur les zones vides
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: controller.searchFormState,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFieldEditWidget(
                            controller: controller.searchController,
                            inputColor: Theme.of(context).highlightColor,
                            hint: "Rechercher",
                            withTitleWhenTexting: false,
                            blocColor: Theme.of(context).highlightColor,
                            validator: (value) =>
                                FieldFormatter.validatorEmpty(value),
                            onChange: (value) async =>
                                await controller.onSearch(),
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(
                    left: AppConstantsUtils.scaffoldHPadding,
                    right: AppConstantsUtils.scaffoldHPadding,
                    top: AppConstantsUtils.scaffoldVPadding,
                  ),
                ),
                Obx(() {
                  if (controller.allUsers.isEmpty) {
                    return SliverFillRemaining(
                        child: Center(
                            child: Text(
                      "Aucun membre pour le moment",
                      style: TextConfig.getSimpleTextStyle(true),
                    )));
                  }
                  return SliverToBoxAdapter(
                    child: Text("${controller.allUsers.length} Membres",
                            style: TextConfig.getSimpleTextStyle(true))
                        .paddingSymmetric(
                      horizontal: AppConstantsUtils.scaffoldHPadding,
                      vertical: AppConstantsUtils.scaffoldHPadding,
                    ),
                  );
                }),
                Obx(() {
                  if (controller.allUsers.isEmpty) {
                    return SliverFillRemaining(child: const SizedBox.shrink());
                  }
                  return SliverList.separated(
                    itemCount: controller.allUsers.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: AppConstantsUtils.itemSpacing,
                      child: Divider(),
                    ),
                    itemBuilder: (context, index) {
                      final item = controller.allUsers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstantsUtils.scaffoldHPadding,
                          vertical: AppConstantsUtils.itemSpacing,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: AppConstantsUtils.itemSpacing,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: item.photo == null
                                  ? AssetImage('assets/images/events.png')
                                  : CachedNetworkImageProvider(
                                      item.photo ?? "",
                                    ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (item.profil != null) ...[
                                    Text(item.profil?.toUpperCase() ?? ""),
                                  ],
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(TablerIcons.list),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
                /*
                SliverToBoxAdapter(
                  child: Text("Ont récemments rejoints",
                          style: TextConfig.getSimpleTextStyle(true))
                      .paddingSymmetric(
                    horizontal: AppConstantsUtils.scaffoldHPadding,
                    vertical: AppConstantsUtils.scaffoldHPadding,
                  ),
                ),
                SliverList.separated(
                  itemCount: controller.allUsers.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppConstantsUtils.itemSpacing,
                    child: Divider(),
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.allUsers[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: AppConstantsUtils.scaffoldHPadding,
                        right: AppConstantsUtils.scaffoldHPadding,
                        top: AppConstantsUtils.itemSpacing,
                        bottom: (index ==
                                DonationDatas.generateDonations().length - 1)
                            ? AppConstantsUtils.scaffoldWidth(context)
                            : AppConstantsUtils.itemSpacing,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: AppConstantsUtils.itemSpacing,
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundImage: item.photo == null
                                  ? AssetImage('assets/images/events.png')
                                  : CachedNetworkImageProvider(
                                      item.photo ?? "",
                                    ),
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    item.name ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (item.profil != null) ...[
                                    Text(item.profil?.toUpperCase() ?? ""),
                                  ],
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(TablerIcons.list),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                */
              ],
            ),
          ),
        ),
      ],
    ).emptyScaffold;
  }
}
