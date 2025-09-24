import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [PublicationType].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [PublicationTypeRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_publication_type.dart';

abstract class PublicationTypeRepository {

  Future<(Failure?, List<EntityPublicationType>)> getAllPublicationType();

  Future<(Failure?, EntityPublicationType?)> getPublicationTypeById({required int id});

  Future<(Failure?, EntityPublicationType?)> createPublicationType(
      {required String typePublication});

  Future<(Failure?, EntityPublicationType?)> updatePublicationType(
      {required int id, required String typePublication});

  Future<(Failure?, VoidType?)> deletePublicationType({required int id});
}
