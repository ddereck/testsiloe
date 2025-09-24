import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_commentaire_report.dart';
import '../../domain/repositories/commentaire_report_repository.dart';
import '../data_sources/commentaire_report_data_source.dart';

/// A class that implements [CommentaireReportRepository].
///
/// The class is named [CommentaireReportRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class CommentaireReportRepositoryImpl implements CommentaireReportRepository {

  final CommentaireReportDataSource dataSource;
  const CommentaireReportRepositoryImpl(this.dataSource);
  
  @override
  Future<(Failure?, EntityCommentaireReport?)> reportCommentaire({required int utilisateurId, required int commentaireId, required String raison}) async {
    try {
      final result = await dataSource.reportCommentaire(utilisateurId: utilisateurId, commentaireId: commentaireId, raison: raison);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }



}
