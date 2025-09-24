import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import 'commentaire_report_data_source.dart';
import '../models/model_commentaire_report.dart';

class CommentaireReportDataSourceImpl implements CommentaireReportDataSource {
  final FirebaseAuth firebaseAuth;

  const CommentaireReportDataSourceImpl(this.firebaseAuth);
  @override
  Future<ModelCommentaireReport?> reportCommentaire({required int utilisateurId, required int commentaireId, required String raison}) {
    // TODO: implement reportCommentaire
    throw UnimplementedError();
  }

}
