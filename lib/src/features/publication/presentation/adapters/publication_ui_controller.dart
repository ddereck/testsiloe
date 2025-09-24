import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:siloe/src/commons/functions/widgets_functions.dart';
import 'package:siloe/src/features/publication/domain/entities/entity_publication.dart';

import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../../categorie/domain/entities/entity_categorie.dart' show EntityCategorie;

class PublicationsUIController extends GetxController {
  Rx<List<EntityPublication>> publications = Rx<List<EntityPublication>>([]);
  Rx<List<EntityPublication>> filteredPublications = Rx<List<EntityPublication>>([]);
  RxBool _initialized = false.obs;

  // Pour recherche
  RxString keyword = ''.obs;
  RxBool isSearching = false.obs;
  RxBool isLoadingSearch = false.obs;
  RxString searchError = ''.obs;

  void setPublications(List<EntityPublication> pubs, {required int page}) {
    publications.value = pubs;
    filteredPublications.value = pubs;
    currentPage.value = page;
    hasNextPage.value = pubs.length == pageSize; // true si encore une page
    update();
  }

  void setFilteredPublications(List<EntityPublication> pubs) {
    filteredPublications.value = pubs;
    update();
  }

  Future<void> initPublications() async {
    await fetchPublications(page: 1);
    _initialized.value = true;
  }

  // void initPublications() async {
  //   final result = await ControllersProvider.PUBLICATION_CONTROLLER.getAllPublications();
  //   setPublications(result);
  //   setFilteredPublications(result);
  //   _initialized.value = true;
  // }

  void initPublicationsIfNeeded() {
    if (_initialized.value == true && publications.value.isNotEmpty) return;
    initPublications();
  }

  void updateFilteredPublicationByCategory(EntityCategorie category) {
    if (category.id == 0) {
      filteredPublications.value = publications.value;
      update();
      return;
    }
    filteredPublications.value = publications.value
        .where((element) => element.categorieId == category.id)
        .toList();
    update();
  }
 // ========== RECHERCHE ==========

  Future<void> searchPublications(String motcle) async {
    // Si motcle vide, remettre liste par défaut
    if (motcle.trim().isEmpty) {
      keyword.value = '';
      setFilteredPublications(publications.value);
      return;
    }

    keyword.value = motcle;
    isSearching.value = true;
    isLoadingSearch.value = true;
    searchError.value = '';

    try {
      final uri = Uri.parse('https://mobile.lereservoirdesiloe.com/api/publications/search/${Uri.encodeComponent(motcle)}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body is List) {
          final List<EntityPublication> results = body
              .map((e) => _publicationFromJson(e))
              .toList();
          setFilteredPublications(results);
        } else {
          // si ton API renvoie { data: [...], ... }
          if (body['data'] is List) {
            final List<EntityPublication> results = (body['data'] as List)
                .map((e) => _publicationFromJson(e))
                .toList();
            setFilteredPublications(results);
          } else {
            // format inattendu
            searchError.value = 'Format de réponse inattendu';
          }
        }
      } else {
        searchError.value = 'Erreur serveur ${response.statusCode}';
      }
    } catch (e) {
      searchError.value = 'Erreur : $e';
    } finally {
      isLoadingSearch.value = false;
      update();
    }
  }

  // Pagination
  RxInt currentPage = 1.obs;
  final int pageSize = 10;
  RxBool hasNextPage = true.obs;
  RxBool isLoading = false.obs;


  // ==================== FETCH ====================
  Future<void> fetchPublications({int page = 1}) async {
    try {
      isLoading.value = true;

      final uri = Uri.parse(
          "https://mobile.lereservoirdesiloe.com/api/publications?page=$page&limit=$pageSize");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        List data = [];
        if (body is List) {
          data = body;
        } else if (body["data"] is List) {
          data = body["data"];
        }

        final pubs = data.map((e) => _publicationFromJson(e)).toList();

        publications.value = pubs.cast<EntityPublication>();
        filteredPublications.value = pubs.cast<EntityPublication>();

        currentPage.value = page;
        hasNextPage.value = pubs.length == pageSize;
      }
    } catch (e) {
      print("Erreur fetchPublications: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void nextPage() {
    if (hasNextPage.value) {
      fetchPublications(page: currentPage.value + 1);
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      fetchPublications(page: currentPage.value - 1);
    }
  }

  EntityPublication _publicationFromJson(Map<String, dynamic> json) {
    return EntityPublication(
      id: json['id'],
      categorieId: json['categorie_id'],
      typePublicationId: json['type_publication_id'],
      titre: json['titre'],
      description: json['description'],
      img: json['img'],
      file: json['file'],
      url: json['url'],
      datePublication: json['date_publication'],
      auteur: json['auteur'],
      duration: json['duration'],
      article: json['article'],
      // categorie: json['categorie'] != null ? EntityCategorie.fromJson(json['categorie']) : null,
    );
  }

  Future<bool> deletePublication({required int id}) async {
    try {
      final result = await ControllersProvider.PUBLICATION_CONTROLLER.deletePublication(id: id);

      if (result == null) {
        customSnackBar(
        title: "Succès",
        message: "Publication supprimée ✅",
        isError: false,
      );
      initPublications();
      return true;
      }

      customSnackBar(
        title: "Succès",
        message: "Publication supprimée ✅",
        isError: false,
      );

      initPublications();
        return true;
    } catch (e) {
      customSnackBar(
        title: "Erreur",
        message: "Exception lors de la suppression: $e",
        isError: true,
      );
      return false;
    }
  }
}