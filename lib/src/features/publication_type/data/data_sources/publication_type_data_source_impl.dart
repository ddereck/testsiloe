import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import '../../../../core/resources/database_attributes_resources.dart' show DatabaseAttributesResources;
import 'publication_type_data_source.dart';
import '../models/model_publication_type.dart';

class PublicationTypeDataSourceImpl implements PublicationTypeDataSource {
  
  final FirebaseAuth firebaseAuth;

  const PublicationTypeDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelPublicationType?> createPublicationType({required String typePublication}) async {
    try {
      final response = await ApiResources.post(ApiRoutes.typePublications, data: {
        ApiParams.typePublication: typePublication,
      });
      if(response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      } 
      return ModelPublicationType.fromJson({
        DatabaseAttributesResources.id: response.data[ApiParams.id] as int?,
        DatabaseAttributesResources.typePublication: response.data[ApiParams.typePublication] as String?,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePublicationType({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.typePublicationById(id));
      if(response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      } 
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelPublicationType>> getAllPublicationType() async {
    try {
      final response = await ApiResources.get(ApiRoutes.typePublications);
      if(response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      } 
      return (response.data as List).map((e) => ModelPublicationType.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelPublicationType?> getPublicationTypeById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.typePublicationById(id));
      if(response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      } 
      return ModelPublicationType.fromJson({
        DatabaseAttributesResources.id: response.data[ApiParams.id] as int?,
        DatabaseAttributesResources.typePublication: response.data[ApiParams.typePublication] as String?,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelPublicationType?> updatePublicationType({required int id, required String typePublication}) async {
    try {
      final response = await ApiResources.put(ApiRoutes.typePublicationById(id), data: {
        ApiParams.typePublication: typePublication,
      });
      if(response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      } 
      return ModelPublicationType.fromJson({
        DatabaseAttributesResources.id: response.data[ApiParams.id] as int?,
        DatabaseAttributesResources.typePublication: response.data[ApiParams.typePublication] as String?,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

}
