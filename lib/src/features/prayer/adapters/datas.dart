import 'package:siloe/src/utils/app_strings.dart';

class EntityPrayerRequest {
  final String message;
  final DateTime date;
  final String fullname;

  EntityPrayerRequest({
    required this.message,
    required this.date,
    required this.fullname,
  });
}

class PrayerDatas {
  static List<EntityPrayerRequest> generatePrayerRequests() {
    final now = DateTime.now();
    return List.generate(20, (index) {
      return EntityPrayerRequest(
        message: AppStrings.lorem,
        date: now
            .subtract(Duration(days: index * 2)), // dates espacées de 2 jours
        fullname: 'Personne ${index + 1}',
      );
    });
  }

  static const String prayerRequestArg = "prayerRequestArg";
}
