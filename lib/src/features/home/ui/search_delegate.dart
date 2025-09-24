import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../di/di_helper.dart' show DiHelper;
import '../../publication/presentation/adapters/publication_ui_controller.dart' show PublicationsUIController;
import '../../publication/presentation/adapters/publication_ui_controller.dart'; 
import '../../../features/article/adapters/article_datas.dart' show ArticleDatas;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;

class PublicationsSearchDelegate extends SearchDelegate<void> {
  final PublicationsUIController pubsCtrl = DiHelper.findOrCreate(creator: () => PublicationsUIController());
  String _lastQuery = '';
  bool _searched = false;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(icon: const Icon(Icons.clear), onPressed: () { query = ''; showSuggestions(context); })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Remet la liste complète (pas de filtre)
        pubsCtrl.setFilteredPublications(pubsCtrl.publications.value);
        // Réinitialise le mot clé
        pubsCtrl.keyword.value = '';
        // Ferme le SearchDelegate
        close(context, null);
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Tu peux afficher suggestions récentes ou rien
    return const SizedBox.shrink();
  }

  @override
  Widget buildResults(BuildContext context) {
    if (!_searched || _lastQuery != query) {
      _searched = true;
      _lastQuery = query;
      pubsCtrl.searchPublications(query);
    }

    return Obx(() {
      if (pubsCtrl.isLoadingSearch.value) return const Center(child: CircularProgressIndicator());
      if (pubsCtrl.searchError.value.isNotEmpty) return Center(child: Text(pubsCtrl.searchError.value));

      final results = pubsCtrl.filteredPublications.value;
      if (results.isEmpty) return Center(child: Text('Aucun résultat pour "$query"'));

      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          return ListTile(
            title: Text(item.titre ?? ''),
            subtitle: Text(item.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
            onTap: () {
              close(context, null);
              RoutesUtils.changePage(AppRoutes.articleDetails, arguments: {ArticleDatas.articleArg: item});
            },
          );
        },
      );
    });
  }
}
