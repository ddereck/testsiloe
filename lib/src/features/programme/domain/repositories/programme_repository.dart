import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [Programme].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [ProgrammeRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_programme.dart';

abstract class ProgrammeRepository {

  Future<(Failure?, List<EntityProgramme>)> getProgrammes({
    String? statut,
    String? type,
    String? dateDebut,
    String? dateFin,
  });

  Future<(Failure?, EntityProgramme?)> getProgrammeById({required int id});

  Future<(Failure?, EntityProgramme?)> createProgramme({
    required String date,
    required String heure,
    required String type,
    String? description,
    String? statut,
  });

  Future<(Failure?, EntityProgramme?)> updateProgramme({
    required int id,
    String? date,
    String? heure,
    String? type,
    String? description,
    String? statut,
  });

  Future<(Failure?, VoidType?)> deleteProgramme({required int id});

}
