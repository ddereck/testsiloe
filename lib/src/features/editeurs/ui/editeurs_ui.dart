import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../home/ui/widgets/floatting_bottom_nav.dart' show FloatingBottomNav;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../presentation/adapters/editeurs_controller.dart' show EditeursController;
import '../../home/adapters/home_ui_controller.dart';
import '../data/models/editeur_model.dart' show EditeurModel;
import '../bindings/editeurs_binding.dart' show EditeursBinding;
import '../../../core/api/api_resources.dart' show ApiResources;

class EditeursUI extends StatelessWidget {
  EditeursUI({super.key});

  @override
  Widget build(BuildContext context) {
    // S'assurer que le binding est initialisé
    if (!Get.isRegistered<EditeursController>()) {
      EditeursBinding().dependencies();
    }
    
    try {
      final EditeursController controller = Get.find<EditeursController>();
      return _buildMainContent(controller);
    } catch (e) {
      return _buildErrorWidget(e.toString());
    }
  }

  Widget _buildMainContent(EditeursController controller) {
    return Builder(
      builder: (context) => Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopbarWidget(title: "Editeurs"),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Obx(
                    () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppConstantsUtils.scaffoldHPadding,
                            vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  autofocus: false,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                decoration: InputDecoration(
                                  hintText: "Saisir email",
                                  hintStyle: const TextStyle(fontSize: 13),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                  onSubmitted: (value) async {
                                    if (value.trim().isEmpty) return;
                                    FocusScope.of(context).unfocus();
                                    controller.clearError();
                                    final ok = await controller.addEditeur(value.trim());
                                    if (ok) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Éditeur ajouté avec succès"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (controller.errorMessage.isNotEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(controller.errorMessage.value),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Material(
                                color: const Color(0xFF7A0C0C),
                              borderRadius: BorderRadius.circular(6),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(6),
                                  onTap: () async {
                                    final email = controller.emailController.text.trim();
                                    if (email.isEmpty) return;
                                    FocusScope.of(context).unfocus();
                                    controller.clearError();
                                    final ok = await controller.addEditeur(email);
                                    if (ok) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Éditeur ajouté avec succès"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (controller.errorMessage.isNotEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(controller.errorMessage.value),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                child: const SizedBox(
                                  width: 44,
                                  height: 36,
                                  child: Icon(Icons.person_add_alt_1,
                                      color: Colors.white, size: 20),
                                ),
                              ),
                            ),
                          ],
                          ),
                        ),
                        if (controller.errorMessage.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppConstantsUtils.scaffoldHPadding),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFFFCDD2)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.error_outline, color: Colors.red, size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      controller.errorMessage.value,
                                      style: const TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppConstantsUtils.scaffoldHPadding),
                        child: Text(
                            "${controller.editeurs.length} Membre(s)",
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                          child: controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  itemCount: controller.editeurs.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                                    final EditeurModel member = controller.editeurs[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                          horizontal: AppConstantsUtils.scaffoldHPadding),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                        leading: _Avatar(photo: member.photo, name: member.name),
                                title: Text(member.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                        subtitle: _RolesSubtitle(mainRole: member.role, roles: member.roles),
                                        trailing: TextButton(
                                          onPressed: () async {
                                            // Confirmation avant suppression
                                            final confirmed = await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text("Confirmer la suppression"),
                                                content: Text("Êtes-vous sûr de vouloir retirer ${member.name} ?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(false),
                                                    child: const Text("Annuler"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(true),
                                                    child: const Text("Retirer", style: TextStyle(color: Colors.red)),
                                                  ),
                                                ],
                                              ),
                                            );
                                            
                                            if (confirmed == true) {
                                              controller.clearError();
                                              final ok = await controller.removeEditeur(member.id);
                                              if (ok) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text("Éditeur retiré avec succès"),
                                                    backgroundColor: Colors.green,
                                                  ),
                                                );
                                              } else if (controller.errorMessage.isNotEmpty) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(controller.errorMessage.value),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        child: const Text("Retirer",
                                              style: TextStyle(color: Colors.red)),
                                        ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () {
              final homeUiController = Get.find<HomeUIController>();
              return FloatingBottomNav(
                selectedIndex: homeUiController.tabIndex.value,
                onItemTapped: (index) {
                  Get.back();
                  homeUiController.changeTabIndex(index);
                },
              );
            },
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Erreur"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              "Erreur de chargement",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Réessayer de charger le controller
                if (Get.isRegistered<EditeursController>()) {
                  Get.delete<EditeursController>();
                }
                EditeursBinding().dependencies();
                // Recharger la page
                Get.off(() => EditeursUI());
              },
              child: const Text("Réessayer"),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? photo;
  final String name;
  const _Avatar({required this.photo, required this.name});

  @override
  Widget build(BuildContext context) {
    final String? url = _normalizePhotoUrl(photo);
    // Debug: afficher l'URL de la photo
    if (photo != null && photo!.isNotEmpty) {
      print('DEBUG Avatar - Photo originale: "$photo" -> URL finale: "$url"');
    }
    
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey[300],
      backgroundImage: (url != null) ? NetworkImage(url) : null,
      child: (url == null)
          ? Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          : null,
    );
  }

  String? _normalizePhotoUrl(String? p) {
    if (p == null || p.isEmpty) return null;
    
    // Déjà absolu (http/https)
    if (p.startsWith('http://') || p.startsWith('https://')) return p;
    
    // Nettoyer les éventuels doubles slash
    final clean = p.replaceAll('\\/', '/');
    
    // Si commence par /, c'est un chemin absolu du serveur
    if (clean.startsWith('/')) {
      return '${ApiResources.baseUrl}$clean';
    }
    
    // Sinon, c'est un chemin relatif
    return '${ApiResources.baseUrl}/$clean';
  }
}

class _RolesSubtitle extends StatelessWidget {
  final String mainRole;
  final List<String> roles;
  const _RolesSubtitle({required this.mainRole, required this.roles});

  @override
  Widget build(BuildContext context) {
    final List<String> all = [
      if (mainRole.isNotEmpty) mainRole,
      ...roles.where((r) => r.isNotEmpty),
    ];
    final text = all.isEmpty ? '' : all.toSet().join(' · ');
    return Text(
      text,
      style: const TextStyle(fontSize: 12),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
