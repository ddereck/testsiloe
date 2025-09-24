import '../repositories/editeurs_repository.dart';

class NommerEditeurUseCase {
  final EditeursRepository repository;

  NommerEditeurUseCase({required this.repository});

  Future<bool> call(int userId) async {
    return await repository.nommerEditeur(userId);
  }
}
