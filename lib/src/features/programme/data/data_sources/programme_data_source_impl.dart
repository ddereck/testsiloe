import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'programme_data_source.dart';
import '../models/model_programme.dart';

class ProgrammeDataSourceImpl implements ProgrammeDataSource {
  final FirebaseAuth firebaseAuth;

  const ProgrammeDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelProgramme?> createProgramme({
    required String date,
    required String heure,
    required String type,
    String? description,
    String? statut,
  }) async {
    try {
      final data = {
        ApiParams.date: date,
        ApiParams.heure: heure,
        ApiParams.type: type,
        if (description != null) ApiParams.description: description,
        if (statut != null) ApiParams.statut: statut,
      };

      final response =
          await ApiResources.post(ApiRoutes.programmes, data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelProgramme.fromJson(response.data['programme']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteProgramme({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.programmeById(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelProgramme?> getProgrammeById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.programmeById(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelProgramme.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelProgramme>> getProgrammes({
    String? statut,
    String? type,
    String? dateDebut,
    String? dateFin,
  }) async {
    try {
      final response = await ApiResources.get(ApiRoutes.programmes, query: {
        if (statut != null) ApiParams.statut: statut,
        if (type != null) ApiParams.type: type,
        if (dateDebut != null) ApiParams.dateDebut: dateDebut,
        if (dateFin != null) ApiParams.dateFin: dateFin,
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelProgramme.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelProgramme?> updateProgramme({
    required int id,
    String? date,
    String? heure,
    String? type,
    String? description,
    String? statut,
  }) async {
    try {
      final data = {
        if (date != null) ApiParams.date: date,
        if (heure != null) ApiParams.heure: heure,
        if (type != null) ApiParams.type: type,
        if (description != null) ApiParams.description: description,
        if (statut != null) ApiParams.statut: statut,
      };

      final response =
          await ApiResources.put(ApiRoutes.programmeById(id), data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelProgramme.fromJson(response.data['programme']);
    } catch (e) {
      throw Exception(e);
    }
  }
}
