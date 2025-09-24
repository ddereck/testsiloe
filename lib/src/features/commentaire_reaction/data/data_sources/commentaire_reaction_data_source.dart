import '../models/model_commentaire_reaction.dart';

abstract class CommentaireReactionDataSource {

  // Ajouter une réaction
  Future<void> addReaction({required int commentaireId, required String type});

  // Supprimer sa réaction
  Future<void> removeReaction({required int commentaireId});

  // Obtenir les stats de réactions
  Future<List<ModelCommentaireReaction>> getReactions({required int commentaireId});

}
