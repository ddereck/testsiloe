import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_publication_type.dart';
import '../../domain/repositories/publication_type_repository.dart';
import '../data_sources/publication_type_data_source.dart';

/// A class that implements [PublicationTypeRepository].
///
/// The class is named [PublicationTypeRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class PublicationTypeRepositoryImpl implements PublicationTypeRepository {

  final PublicationTypeDataSource dataSource;
  const PublicationTypeRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, EntityPublicationType?)> createPublicationType({required String typePublication}) async {
    try {
      final result = await dataSource.createPublicationType(typePublication: typePublication);
      return (null, result?.toEntity());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<(Failure?, VoidType?)> deletePublicationType({required int id}) async {
    try {
      await dataSource.deletePublicationType(id: id);
      return (null, VoidType());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<(Failure?, List<EntityPublicationType>)> getAllPublicationType() async {
    try {
      final result = await dataSource.getAllPublicationType();
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<(Failure?, EntityPublicationType?)> getPublicationTypeById({required int id}) async {
    try {
      final result = await dataSource.getPublicationTypeById(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<(Failure?, EntityPublicationType?)> updatePublicationType({required int id, required String typePublication}) async {
    try {
      final result = await dataSource.updatePublicationType(id: id, typePublication: typePublication);
      return (null, result?.toEntity());
    } catch (e) {
      throw Exception(e);
    }
  }

}
