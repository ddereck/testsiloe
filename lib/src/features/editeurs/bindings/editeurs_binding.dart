import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../data/data_sources/editeurs_data_source.dart';
import '../data/data_sources/editeurs_data_source_impl.dart';
import '../data/repositories_impl/editeurs_repository_impl.dart';
import '../domain/repositories/editeurs_repository.dart';
import '../domain/usecases/get_editeurs_usecase.dart';
import '../domain/usecases/get_user_by_email_usecase.dart';
import '../domain/usecases/nommer_editeur_usecase.dart';
import '../domain/usecases/retirer_editeur_usecase.dart';
import '../presentation/adapters/editeurs_controller.dart';

class EditeursBinding extends Bindings {
  @override
  void dependencies() {
    // HTTP Client
    Get.lazyPut<http.Client>(() => http.Client());

    // Data Source
    Get.lazyPut<EditeursDataSource>(
      () => EditeursDataSourceImpl(
        httpClient: Get.find<http.Client>(),
      ),
    );

    // Repository
    Get.lazyPut<EditeursRepository>(
      () => EditeursRepositoryImpl(
        dataSource: Get.find<EditeursDataSource>(),
      ),
    );

    // Use Cases
    Get.lazyPut<GetEditeursUseCase>(
      () => GetEditeursUseCase(
        repository: Get.find<EditeursRepository>(),
      ),
    );

    Get.lazyPut<GetUserByEmailUseCase>(
      () => GetUserByEmailUseCase(
        repository: Get.find<EditeursRepository>(),
      ),
    );

    Get.lazyPut<NommerEditeurUseCase>(
      () => NommerEditeurUseCase(
        repository: Get.find<EditeursRepository>(),
      ),
    );

    Get.lazyPut<RetirerEditeurUseCase>(
      () => RetirerEditeurUseCase(
        repository: Get.find<EditeursRepository>(),
      ),
    );

    // Controller
    Get.lazyPut<EditeursController>(
      () => EditeursController(
        getEditeursUseCase: Get.find<GetEditeursUseCase>(),
        getUserByEmailUseCase: Get.find<GetUserByEmailUseCase>(),
        nommerEditeurUseCase: Get.find<NommerEditeurUseCase>(),
        retirerEditeurUseCase: Get.find<RetirerEditeurUseCase>(),
      ),
    );
  }
}
