import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/glass_effect_extension.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../categorie/presentation/ui/widgets/categories_list_widget.dart'
    show CategoriesListWidget;
import '../../publication/presentation/ui/widgets/publications_list_widget.dart'
    show PublicationsListWidget;
import '../../../features/user/presentation/adapters/user_controller.dart';
import '../ui/search_delegate.dart';
import '../../publication/presentation/adapters/publication_ui_controller.dart' show PublicationsUIController;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _refresh() async {
    Get.offAllNamed(AppRoutes.home); 
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF7A0C0C),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: SafeArea(child: SizedBox(height: 50)),
                  ),
                  // Section "Quoi de neuf ?" 
                  SliverToBoxAdapter(
                      child: GetX<UserController>(
                        builder: (userController) {
                          if (userController.isAdminOrReverendOrEditeur) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: AppConstantsUtils.scaffoldHPadding,
                                vertical: 8,
                              ),
                              child: InkWell(
                                onTap: () =>
                                    RoutesUtils.changePage(AppRoutes.addArticle),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        TablerIcons.edit,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "Quoi de neuf ?",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        TablerIcons.photo,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        TablerIcons.video,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  // Catégories 
                  SliverToBoxAdapter(
                    child: const CategoriesListWidget().marginOnly(
                      left: AppConstantsUtils.scaffoldHPadding,
                      right: AppConstantsUtils.scaffoldHPadding,
                    ),
                  ),
                  // Liste filtrée Publications
                  const PublicationsListWidget(),
                  SliverToBoxAdapter(
                    child: Obx(() {
                      final controller = Get.find<PublicationsUIController>();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: controller.currentPage.value > 1
                                ? controller.previousPage
                                : null,
                            child: const Text("Pré"),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: controller.hasNextPage.value
                                ? controller.nextPage
                                : null,
                            child: const Text("Suiv"),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 12);
                    }),
                  ),
                  // SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     height: MediaQuery.of(context).padding.bottom + 80,
                  //   ),
                  // ),
                ],
              ),
            ),
            // Header fixe
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 50,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                      ),
                      const SizedBox(width: AppConstantsUtils.itemSpacing),
                      Flexible(
                        child: Center(
                          child: Text(
                            "LE RESERVOIR DE SILOE".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          RoutesUtils.changePage(AppRoutes.notifications);
                        },
                        child: const Icon(TablerIcons.bell,
                            color: Color.fromARGB(255, 0, 0, 0), size: 20),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          // Action recherche
                          showSearch(context: context, delegate: PublicationsSearchDelegate());
                        },
                        child: const Icon(TablerIcons.search,
                            color: Color.fromARGB(255, 0, 0, 0), size: 20),
                      ),
                    ],
                  ),
                ).withGlassEffect(
                  blur: 15,
                  opacity: 0.5,
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            // Barre de statut
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Builder(builder: (context) {
                final top = MediaQuery.of(context).padding.top;
                return Container(
                  height: top,
                  color: const Color(0xFF7A0C0C),
                );
              }),
            ),
          ],
        ),
      ),
    ).simpleScaffoldWithProps();
  }
}
