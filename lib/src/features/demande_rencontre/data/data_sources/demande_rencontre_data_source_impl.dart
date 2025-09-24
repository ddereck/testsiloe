import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'demande_rencontre_data_source.dart';
import '../models/model_demande_rencontre.dart';

class DemandeRencontreDataSourceImpl implements DemandeRencontreDataSource {
  final FirebaseAuth firebaseAuth;

  const DemandeRencontreDataSourceImpl(this.firebaseAuth);

  Future<ModelDemandeRencontre?> _postAction(String url) async {
    try {
      final response = await ApiResources.post(url);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelDemandeRencontre.fromJson(response.data['demande']);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<ModelDemandeRencontre?> accepterDemande({required int id}) async {
    return _postAction(ApiRoutes.demandeRencontreAccepter(id));
  }
  
  @override
  Future<ModelDemandeRencontre?> annulerDemande({required int id}) async {
    return _postAction(ApiRoutes.demandeRencontreAnnuler(id));
  }
  
  @override
  Future<ModelDemandeRencontre?> createDemandeRencontre({required String nomPrenoms, required String email, required String telephone, 
    required String date, required String objet}) async {
    try {
      final data = {
        ApiParams.nomPrenoms: nomPrenoms,
        ApiParams.email: email,
        ApiParams.telephone: telephone,
        ApiParams.date: date,
        ApiParams.objet: objet,
      };

      final response = await ApiResources.post(ApiRoutes.demandesRencontreBase, data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelDemandeRencontre.fromJson(response.data['demande']);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<void> deleteDemande({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.demandeRencontreDelete(id));

      if (response.statusCode != 200 && response.statusCode != 201 && response.statusCode != 204) {
        throw Exception(response.data);
      }

      return;
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<ModelDemandeRencontre?> getDemandeById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.demandeRencontreShow(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelDemandeRencontre.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<List<ModelDemandeRencontre>> getDemandes({String? statut, int? utilisateurId}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.demandesRencontreBase, query: {
        if (statut != null) ApiParams.statut: statut,
        if (utilisateurId != null) ApiParams.utilisateurId: utilisateurId.toString(),
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelDemandeRencontre.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<List<ModelDemandeRencontre>> getMesDemandes() async {
    try {
      final response = await ApiResources.get(ApiRoutes.demandesRencontreMes);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelDemandeRencontre.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<ModelDemandeRencontre?> refuserDemande({required int id}) async {
    return _postAction(ApiRoutes.demandeRencontreRefuser(id));
  }
  
  @override
  Future<ModelDemandeRencontre?> updateDemande({required int id, String? nomPrenoms, String? email, String? telephone, 
    String? date, String? objet, String? statut}) async {
    try {
      final data = {
        if (nomPrenoms != null) ApiParams.nomPrenoms: nomPrenoms,
        if (email != null) ApiParams.email: email,
        if (telephone != null) ApiParams.telephone: telephone,
        if (date != null) ApiParams.date: date,
        if (objet != null) ApiParams.objet: objet,
        if (statut != null) ApiParams.statut: statut,
      };

      final response = await ApiResources.put(ApiRoutes.demandeRencontreUpdate(id), data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelDemandeRencontre.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }



}
