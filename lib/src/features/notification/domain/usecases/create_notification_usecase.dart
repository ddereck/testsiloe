import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_notification.dart' show EntityNotification;
import '../repositories/notification_repository.dart'
    show NotificationRepository;

/// A concrete implementation of [CreateNotificationUseCase] with parameters.
///
/// This class requires a [NotificationRepository] to function.
/// It calls the repository method with the given parameters.
class CreateNotificationUseCase
    implements UseCase<EntityNotification, CreateNotificationUseCaseParams> {
  /// Repository to interact with data layer.
  final NotificationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateNotificationUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityNotification?)> call(
      CreateNotificationUseCaseParams params) async {
    return await repository.createNotification(
      titre: params.titre,
      message: params.message,
      type: params.type,
      utilisateurId: params.utilisateurId,
      data: params.data,
    );
  }
}

/// Parameter class for [CreateNotificationUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreateNotificationUseCaseParams {
  final String titre;
  final String message;
  final String? type;
  final int? utilisateurId;
  final Map<String, dynamic>? data;

  /// Creates an instance of [CreateNotificationUseCaseParams].
  const CreateNotificationUseCaseParams({
    required this.titre,
    required this.message,
    this.type,
    this.utilisateurId,
    this.data,
  });
}
