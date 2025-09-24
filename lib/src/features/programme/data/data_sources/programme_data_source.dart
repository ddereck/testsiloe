import '../models/model_programme.dart';

abstract class ProgrammeDataSource {
  Future<List<ModelProgramme>> getProgrammes({
    String? statut,
    String? type,
    String? dateDebut,
    String? dateFin,
  });

  Future<ModelProgramme?> getProgrammeById({required int id});

  Future<ModelProgramme?> createProgramme({
    required String date,
    required String heure,
    required String type,
    String? description,
    String? statut,
  });

  Future<ModelProgramme?> updateProgramme({
    required int id,
    String? date,
    String? heure,
    String? type,
    String? description,
    String? statut,
  });

  Future<void> deleteProgramme({required int id});
}
