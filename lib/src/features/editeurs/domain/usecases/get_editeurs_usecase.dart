import '../../data/models/editeur_model.dart';
import '../repositories/editeurs_repository.dart';

class GetEditeursUseCase {
  final EditeursRepository repository;

  GetEditeursUseCase({required this.repository});

  Future<List<EditeurModel>> call() async {
    return await repository.getEditeurs();
  }
}
