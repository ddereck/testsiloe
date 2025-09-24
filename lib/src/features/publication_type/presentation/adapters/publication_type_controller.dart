import 'package:get/get.dart';
import 'package:siloe/src/features/publication_type/domain/entities/entity_publication_type.dart';

import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/params.dart' show NoParams, VoidType;
import '../../domain/usecases/create_publication_type_usecase.dart'
    show CreatePublicationTypeUseCase, CreatePublicationTypeUseCaseParams;
import '../../domain/usecases/delete_publication_type_usecase.dart'
    show DeletePublicationTypeUseCase, DeletePublicationTypeUseCaseParams;
import '../../domain/usecases/get_all_publication_type_usecase.dart'
    show GetAllPublicationTypeUseCase;
import '../../domain/usecases/get_publication_type_by_id_usecase.dart'
    show GetPublicationTypeByIdUseCase, GetPublicationTypeByIdUseCaseParams;
import '../../domain/usecases/update_publication_type_usecase.dart'
    show UpdatePublicationTypeUseCase, UpdatePublicationTypeUseCaseParams;

// UseCases

class PublicationTypeController extends GetxController {
  final GetAllPublicationTypeUseCase getAllPublicationTypeUseCase;
  final GetPublicationTypeByIdUseCase getPublicationTypeByIdUseCase;
  final DeletePublicationTypeUseCase deletePublicationTypeUseCase;
  final CreatePublicationTypeUseCase createPublicationTypeUseCase;
  final UpdatePublicationTypeUseCase updatePublicationTypeUseCase;

  PublicationTypeController({
    required this.getAllPublicationTypeUseCase,
    required this.getPublicationTypeByIdUseCase,
    required this.deletePublicationTypeUseCase,
    required this.createPublicationTypeUseCase,
    required this.updatePublicationTypeUseCase,
  });

  Future<List<EntityPublicationType>> getAllPublicationType() async {
    try {
      final result = await getAllPublicationTypeUseCase.call(NoParams());
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting publication types: ${result.$2.toString()}", error: result.$2);
        return [];
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting publication types: $e");
      return [];
    }
  }

  Future<EntityPublicationType?> getPublicationTypeById({required int id}) async {
    try {
      final result = await getPublicationTypeByIdUseCase.call(GetPublicationTypeByIdUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting publication type by id: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting publication type by id: $e");
      return null;
    }
  }

  Future<EntityPublicationType?> createPublicationType({required String typePublication}) async {
    try {
      final result = await createPublicationTypeUseCase.call(CreatePublicationTypeUseCaseParams(typePublication: typePublication));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while creating publication type: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating publication type: $e");
      return null;
    }
  }

  Future<EntityPublicationType?> updatePublicationType({required int id, required String typePublication}) async {
    try {
      final result = await updatePublicationTypeUseCase.call(UpdatePublicationTypeUseCaseParams(id: id, typePublication: typePublication));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while updating publication type: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while updating publication type: $e");
      return null;
    }
  }

  Future<VoidType?> deletePublicationType({required int id}) async {
    try {
      final result = await deletePublicationTypeUseCase.call(DeletePublicationTypeUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while deleting publication type: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting publication type: $e");
      return null;
    }
  }
}
