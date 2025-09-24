import 'package:get/get.dart';
import 'package:siloe/src/core/logs/custom_logger.dart';

// UseCases
import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_programme.dart' show EntityProgramme;
import '../../domain/usecases/create_programme_usecase.dart'
    show CreateProgrammeUseCase, CreateProgrammeUseCaseParams;
import '../../domain/usecases/delete_programme_usecase.dart'
    show DeleteProgrammeUseCase, DeleteProgrammeUseCaseParams;
import '../../domain/usecases/get_programme_by_id_usecase.dart'
    show GetProgrammeByIdUseCase, GetProgrammeByIdUseCaseParams;
import '../../domain/usecases/get_programmes_usecase.dart'
    show GetProgrammesUseCase, GetProgrammesUseCaseParams;
import '../../domain/usecases/update_programme_usecase.dart'
    show UpdateProgrammeUseCase, UpdateProgrammeUseCaseParams;

class ProgrammeController extends GetxController {
  final GetProgrammesUseCase getProgrammesUseCase;
  final GetProgrammeByIdUseCase getProgrammeByIdUseCase;
  final CreateProgrammeUseCase createProgrammeUseCase;
  final UpdateProgrammeUseCase updateProgrammeUseCase;
  final DeleteProgrammeUseCase deleteProgrammeUseCase;

  ProgrammeController({
    required this.getProgrammesUseCase,
    required this.getProgrammeByIdUseCase,
    required this.createProgrammeUseCase,
    required this.updateProgrammeUseCase,
    required this.deleteProgrammeUseCase,
  });

  Future<List<EntityProgramme>> getProgrammes({
    String? statut,
    String? type,
    String? dateDebut,
    String? dateFin,
  }) async {
    try {
      final result = await getProgrammesUseCase.call(GetProgrammesUseCaseParams(
        statut: statut,
        type: type,
        dateDebut: dateDebut,
        dateFin: dateFin,
      ));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting programmes: ${result.$2.toString()}",
            error: result.$2);
        return [];
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting programmes: $e");
      return [];
    }
  }

  Future<EntityProgramme?> getProgrammeById({required int id}) async {
    try {
      final result = await getProgrammeByIdUseCase.call(GetProgrammeByIdUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting programme by id: ${result.$2.toString()}",
            error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting programme by id: $e");
      return null;
    }
  }

  Future<EntityProgramme?> createProgramme({required String date, required String heure, required String type, String? description, String? statut}) async {
    try {
      final result = await createProgrammeUseCase.call(CreateProgrammeUseCaseParams(date: date, heure: heure, type: type, description: description, statut: statut));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while creating programme: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating programme: $e");
      return null;
    }
  }

  Future<EntityProgramme?> updateProgramme({required int id, String? date, String? heure, String? type, String? description, String? statut}) async {
    try {
      final result = await updateProgrammeUseCase.call(UpdateProgrammeUseCaseParams(id: id, date: date, heure: heure, type: type, description: description, statut: statut));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while updating programme: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while updating programme: $e");
      return null;
    }
  }

  Future<VoidType?> deleteProgramme({required int id}) async {
    try {
      final result = await deleteProgrammeUseCase.call(DeleteProgrammeUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while deleting programme: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting programme: $e");
      return null;
    }
  }
}
