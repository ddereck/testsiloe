import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_commentaire_reaction.dart';
import '../../domain/repositories/commentaire_reaction_repository.dart';
import '../data_sources/commentaire_reaction_data_source.dart';

/// A class that implements [CommentaireReactionRepository].
///
/// The class is named [CommentaireReactionRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class CommentaireReactionRepositoryImpl implements CommentaireReactionRepository {

  final CommentaireReactionDataSource dataSource;
  const CommentaireReactionRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, VoidType?)> addReaction({required int commentaireId, required String type}) async {
    try {
      await dataSource.addReaction(commentaireId: commentaireId, type: type);
      return (null, VoidType());
    } catch (e) {
      rethrow; 
    }
  }

  @override
  Future<(Failure?, List<EntityCommentaireReaction>)> getReactions({required int commentaireId}) async {
    try {
      final reactions = await dataSource.getReactions(commentaireId: commentaireId);
      return (null, reactions.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> removeReaction({required int commentaireId}) async {
    try {
      await dataSource.removeReaction(commentaireId: commentaireId);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

}
