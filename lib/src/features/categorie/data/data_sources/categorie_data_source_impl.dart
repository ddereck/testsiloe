import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'categorie_data_source.dart';
import '../models/model_categorie.dart';

class CategorieDataSourceImpl implements CategorieDataSource {
  final FirebaseAuth firebaseAuth;

  const CategorieDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelCategorie?> createCategorie(
      {required String nomCategorie}) async {
    try {
      final response = await ApiResources.post(ApiRoutes.categories, data: {
        ApiParams.nomCategorie: nomCategorie,
      });
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelCategorie.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCategorie({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.categorieById(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelCategorie>> getAllCategories(
      {String? search, int perPage = 20}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.categories, query: {
        ApiParams.search: search,
        ApiParams.perPage: perPage.toString(),
      });
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return (response.data['data'] as List)
          .map((e) => ModelCategorie.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelCategorie?> getCategorieById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.categorieById(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelCategorie.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelCategorie?> updateCategorie(
      {required int id, required String nomCategorie}) async {
    try {
      final response =
          await ApiResources.put(ApiRoutes.categorieById(id), data: {
        ApiParams.nomCategorie: nomCategorie,
      });
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelCategorie.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
