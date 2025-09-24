import '../models/model_categorie.dart';

abstract class CategorieDataSource {
  Future<List<ModelCategorie>> getAllCategories(
      {String? search, int perPage = 20});

  Future<ModelCategorie?> getCategorieById({required int id});

  Future<ModelCategorie?> createCategorie({required String nomCategorie});

  Future<ModelCategorie?> updateCategorie(
      {required int id, required String nomCategorie});

  Future<void> deleteCategorie({required int id});
}
