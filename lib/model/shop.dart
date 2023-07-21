class Shop {
  const Shop(
      {required this.name,
      required this.evaluationList,
      required this.address,
      required this.telephoneNumber,
      required this.openTime,
      required this.closeTime});

  final String name;
  final List<Evaluation> evaluationList;
  final String address;
  final String telephoneNumber;
  final List<String> openTime; // 営業開始時間 0:月, 6:日
  final List<String> closeTime; // 営業終了時間 0:月, 6:日

  Shop.fromMap(Map<String, dynamic> data)
      : name = data['shop_name'],
        evaluationList = [],
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
      {required this.id,
        required this.name,
        required this.value});

  final String id;
  final String name;
  final int value;
}
