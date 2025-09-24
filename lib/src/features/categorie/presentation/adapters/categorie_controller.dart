import 'package:get/get.dart';

import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_categorie.dart' show EntityCategorie;
import '../../domain/usecases/create_categorie_usecase.dart' show CreateCategorieUseCase, CreateCategorieUseCaseParams;
import '../../domain/usecases/delete_categorie_usecase.dart' show DeleteCategorieUseCase, DeleteCategorieUseCaseParams;
import '../../domain/usecases/get_all_categories_usecase.dart' show GetAllCategoriesUseCase, GetAllCategoriesUseCaseParams;
import '../../domain/usecases/get_categrorie_by_id_usecase.dart' show GetCategorieByIdUseCase, GetCategorieByIdUseCaseParams;
import '../../domain/usecases/update_categorie_usecase.dart' show UpdateCategorieUseCase, UpdateCategorieUseCaseParams;

// UseCases

class CategorieController extends GetxController {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetCategorieByIdUseCase getCategorieByIdUseCase;
  final DeleteCategorieUseCase deleteCategorieUseCase;
  final CreateCategorieUseCase createCategorieUseCase;
  final UpdateCategorieUseCase updateCategorieUseCase;

  CategorieController({
    required this.getAllCategoriesUseCase,
    required this.getCategorieByIdUseCase,
    required this.deleteCategorieUseCase,
    required this.createCategorieUseCase,
    required this.updateCategorieUseCase,
  });

  Future<List<EntityCategorie>> getAllCategories({int perPage = 20, String? search}) async {
    try {
      final result = await getAllCategoriesUseCase.call(GetAllCategoriesUseCaseParams(search: search, perPage: perPage));
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting categories: ${result.$2.toString()}", error: result.$2);
        return [];
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting categories: $e");
      return [];
    }
  }

  Future<EntityCategorie?> getCategorieById({required int id}) async {
    try {
      final result = await getCategorieByIdUseCase.call(GetCategorieByIdUseCaseParams(id: id));
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting categories: ${result.$2.toString()}", error: result.$2);
        return null;
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting categories: $e");
      return null;
    }
  }

  Future<VoidType?> deleteCategorie({required int id}) async {
    try {
      final result = await deleteCategorieUseCase.call(DeleteCategorieUseCaseParams(id: id));
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while deleting categories: ${result.$2.toString()}", error: result.$2);
        return null;
      }

      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting categories: $e");
      return null;
    }
  }

  Future<EntityCategorie?> createCategorie({required String nomCategorie}) async {
    try {
      final result = await createCategorieUseCase.call(CreateCategorieUseCaseParams(nomCategorie: nomCategorie));
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while creating categories: ${result.$2.toString()}", error: result.$2);
        return null;
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating categories: $e");
      return null;
    }
  }

  Future<EntityCategorie?> updateCategorie({required int id, required String nomCategorie}) async {
    try {
      final result = await updateCategorieUseCase.call(UpdateCategorieUseCaseParams(id: id, nomCategorie: nomCategorie));
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while updating categories: ${result.$2.toString()}", error: result.$2);
        return null;
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while updating categories: $e");
      return null;
    }
  }
}
