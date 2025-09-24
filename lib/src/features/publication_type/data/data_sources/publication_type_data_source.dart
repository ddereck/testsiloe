import '../models/model_publication_type.dart';

abstract class PublicationTypeDataSource {

  Future<List<ModelPublicationType>> getAllPublicationType();

  Future<ModelPublicationType?> getPublicationTypeById({required int id});

  Future<ModelPublicationType?> createPublicationType({required String typePublication});

  Future<ModelPublicationType?> updatePublicationType({required int id, required String typePublication});

  Future<void> deletePublicationType({required int id});
}
