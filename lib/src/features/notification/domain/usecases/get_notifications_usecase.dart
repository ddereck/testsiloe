import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_notification.dart' show EntityNotification;
import '../repositories/notification_repository.dart'
    show NotificationRepository;

/// A concrete implementation of [GetNotificationsUseCase] with parameters.
///
/// This class requires a [NotificationRepository] to function.
/// It calls the repository method with the given parameters.
class GetNotificationsUseCase
    implements UseCase<List<EntityNotification>, GetNotificationsUseCaseParams> {
  /// Repository to interact with data layer.
  final NotificationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetNotificationsUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityNotification>)> call(
      GetNotificationsUseCaseParams params) async {
    return await repository.getNotifications(
      statut: params.statut,
      lu: params.lu,
      page: params.page,
      perPage: params.perPage,
    );
  }
}

/// Parameter class for [GetNotificationsUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetNotificationsUseCaseParams {
  final String? statut;
  final bool? lu;
  final int? page;
  final int? perPage;

  /// Creates an instance of [GetNotificationsUseCaseParams].
  const GetNotificationsUseCaseParams({
    this.statut,
    this.lu,
    this.page,
    this.perPage,
  });
}
