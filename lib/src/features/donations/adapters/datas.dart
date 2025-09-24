class EntityDonation {
  final double price;
  final DateTime date;
  final String donor;

  EntityDonation({
    required this.price,
    required this.date,
    required this.donor,
  });
}

class DonationDatas {
  static List<EntityDonation> generateDonations() {
    final now = DateTime.now();
    return List.generate(20, (index) {
      return EntityDonation(
        price: (index + 1) * 10.0, // ex: 10.0, 20.0, 30.0 ...
        date: now
            .subtract(Duration(days: index * 5)), // dates espacées de 5 jours
        donor: 'Donor #${index + 1}',
      );
    });
  }

  static List<int> donationPrices = [1000, 5000, 10000, 20000, 50000, 100000];

  static List<String> momos = ["MTN Momo", "Celtis", "Moov Money"];
}
