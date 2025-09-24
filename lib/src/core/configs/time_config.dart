import 'package:intl/intl.dart' show DateFormat;

class TimeConfig {
  static const int oneSecond = 1000;
  static const int oneMinute = 60 * oneSecond;
  static const int oneHour = 60 * oneMinute;
  static const int oneDay = 24 * oneHour;

  static String parseAnyDateFormatted(dynamic input) {
    DateTime date;

    try {
      // 1. Si c'est déjà un DateTime
      if (input is DateTime) {
        date = input;
      }
      // 2. Si c'est un entier (timestamp unix en secondes ou millisecondes)
      else if (input is int) {
        if (input > 1000000000000) {
          date = DateTime.fromMillisecondsSinceEpoch(input, isUtc: true);
        } else {
          date = DateTime.fromMillisecondsSinceEpoch(input * 1000, isUtc: true);
        }
      }
      // 3. Si c'est une chaîne (ISO, numérique, etc.)
      else if (input is String) {
        try {
          date = DateTime.parse(input);
        } catch (_) {
          final n = int.tryParse(input);
          if (n != null) {
            if (input.length >= 13) {
              date = DateTime.fromMillisecondsSinceEpoch(n, isUtc: true);
            } else {
              date = DateTime.fromMillisecondsSinceEpoch(n * 1000, isUtc: true);
            }
          } else {
            // Si parse échoue
            date = DateTime.now().toUtc();
          }
        }
      } else {
        // Si format inconnu
        date = DateTime.now().toUtc();
      }
    } catch (_) {
      date = DateTime.now().toUtc();
    }

    // Formattage en JJ/MM/AAAA
    return DateFormat('dd/MM/yyyy').format(date.toLocal());
  }

  static String formatDateFr(String? date) {
    if (date == null || date.isEmpty) return '-';
    final dt = DateTime.tryParse(date);
    if (dt == null) return '-';
    final mois = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return '${dt.day} ${mois[dt.month - 1]} ${dt.year}';
  }
}
