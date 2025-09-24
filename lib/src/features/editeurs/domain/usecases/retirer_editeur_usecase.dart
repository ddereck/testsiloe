import '../repositories/editeurs_repository.dart';

class RetirerEditeurUseCase {
  final EditeursRepository repository;

  RetirerEditeurUseCase({required this.repository});

  Future<bool> call(int userId) async {
    return await repository.retirerEditeur(userId);
  }
}
