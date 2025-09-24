import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import 'commentaire_reaction_data_source.dart';
import '../models/model_commentaire_reaction.dart';

class CommentaireReactionDataSourceImpl implements CommentaireReactionDataSource {
  final FirebaseAuth firebaseAuth;

  const CommentaireReactionDataSourceImpl(this.firebaseAuth);
  @override
  Future<void> addReaction({required int commentaireId, required String type}) {
    // TODO: implement addReaction
    throw UnimplementedError();
  }

  @override
  Future<List<ModelCommentaireReaction>> getReactions({required int commentaireId}) {
    // TODO: implement getReactions
    throw UnimplementedError();
  }

  @override
  Future<void> removeReaction({required int commentaireId}) {
    // TODO: implement removeReaction
    throw UnimplementedError();
  }

}
