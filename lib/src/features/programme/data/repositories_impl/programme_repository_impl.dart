import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_programme.dart';
import '../../domain/repositories/programme_repository.dart';
import '../data_sources/programme_data_source.dart';

/// A class that implements [ProgrammeRepository].
///
/// The class is named [ProgrammeRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class ProgrammeRepositoryImpl implements ProgrammeRepository {

  final ProgrammeDataSource dataSource;
  const ProgrammeRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, EntityProgramme?)> createProgramme({required String date, required String heure, 
    required String type, String? description, String? statut}) async {
    try {
      final result = await dataSource.createProgramme(date: date, heure: heure, type: type, description: description, statut: statut);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deleteProgramme({required int id}) async {
    try {
      await dataSource.deleteProgramme(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityProgramme?)> getProgrammeById({required int id}) async {
    try {
      final result = await dataSource.getProgrammeById(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityProgramme>)> getProgrammes({String? statut, String? type, String? dateDebut, String? dateFin}) async {
    try {
      final result = await dataSource.getProgrammes(statut: statut, type: type, dateDebut: dateDebut, dateFin: dateFin);
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityProgramme?)> updateProgramme({required int id, String? date, String? heure, String? type, 
    String? description, String? statut}) async {
    try {
      final result = await dataSource.updateProgramme(id: id, date: date, heure: heure, type: type, description: description, statut: statut);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }



}
