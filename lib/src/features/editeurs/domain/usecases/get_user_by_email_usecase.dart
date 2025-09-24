import '../../data/models/editeur_model.dart';
import '../repositories/editeurs_repository.dart';

class GetUserByEmailUseCase {
  final EditeursRepository repository;

  GetUserByEmailUseCase({required this.repository});

  Future<EditeurModel?> call(String email) async {
    return await repository.getUserByEmail(email);
  }
}
