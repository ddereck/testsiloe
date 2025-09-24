import '../models/model_commentaire_report.dart';

abstract class CommentaireReportDataSource {

  // Signaler un commentaire
  Future<ModelCommentaireReport?> reportCommentaire({
    required int utilisateurId,
    required int commentaireId,
    required String raison,
  });

}
