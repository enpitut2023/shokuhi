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
  final List<String> openTime; // 営業開始時間 0:月, 6:日
  final List<String> closeTime; // 営業終了時間 0:月, 6:日

  Shop.fromMap(Map<String, dynamic> data)
      : name = data['shop_name'],
        tags = ['tag1', 'tag2'],
        evaluation = Evaluation(
          meat: 2,
          fish: 3,
          vegetable: 4,
          frozenFood: 2,
          dairy: 3,
        ),
        address = data['shop_address'],
        telephoneNumber = data['shop_tel'],
        openTime = [
          data['shop_open']['Sunday'],
          data['shop_open']['Monday'],
          data['shop_open']['Tuesday'],
          data['shop_open']['Wednesday'],
          data['shop_open']['Thursday'],
          data['shop_open']['Friday'],
          data['shop_open']['Saturday'],
        ],
        closeTime = [
          data['shop_close']['Sunday'],
          data['shop_close']['Monday'],
          data['shop_close']['Tuesday'],
          data['shop_close']['Wednesday'],
          data['shop_close']['Thursday'],
          data['shop_close']['Friday'],
          data['shop_close']['Saturday'],
        ];
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
  int dairy = 0;
}
