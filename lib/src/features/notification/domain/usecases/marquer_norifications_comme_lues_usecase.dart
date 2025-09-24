import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show NoParams, VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/notification_repository.dart' show NotificationRepository;

/// A concrete implementation of [MarquerNotificationsCommeLuesUseCase] with parameters.
///
/// This class requires a [NotificationRepository] to function.
/// It calls the repository method with the given parameters.
class MarquerNotificationsCommeLuesUseCase implements UseCase<VoidType, NoParams> {
  /// Repository to interact with data layer.
  final NotificationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const MarquerNotificationsCommeLuesUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(NoParams params) async {
    return await repository.marquerToutesCommeLues();
  }
}