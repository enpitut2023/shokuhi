class Shop {
  const Shop(
      {required this.name,
      required this.tags,
      required this.evaluation,
      required this.address,
      required this.telephoneNumber,
      required this.openTime,
      required this.closeTime});

  final String name;
  final List<String> tags;
  final Evaluation evaluation;
  final String address;
  final String telephoneNumber;
  final List<DateTime> openTime; // 営業開始時間 0:月, 6:日
  final List<DateTime> closeTime; // 営業終了時間 0:月, 6:日
}

class Evaluation {
  Evaluation(
      {required this.meat,
      required this.fish,
      required this.vegetable,
      required this.frozenFood,
      required this.dairy});

  int meat = 0;
  int fish = 0;
  int vegetable = 0;
  int frozenFood = 0;
  int dairy;
}
