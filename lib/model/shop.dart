class Shop {
  const Shop(
      {required this.name,
      required this.evaluationList,
      required this.address,
      required this.telephoneNumber,
      required this.openTime,
      required this.closeTime,
      required this.comments,
      required this.longitude,
      required this.latitude});

  final String name;
  final List<Evaluation> evaluationList;
  final String address;
  final String telephoneNumber;
  final List<String> openTime; // 営業開始時間 0:月, 6:日
  final List<String> closeTime; // 営業終了時間 0:月, 6:日
  final List<String> comments;
  final double longitude, latitude;

  Shop.fromMap(Map<String, dynamic> data, this.evaluationList)
      : name = data['shop_name'],
        address = data['shop_address'],
        telephoneNumber = data['shop_tel'],
        longitude = data['longitude'],
        latitude = data['latitude'],
        comments = (data['comments'] != null)
            ? [for (final val in data['comments'].values) val]
            : [],
        openTime = [
          data['shop_open']['Sunday'],
          data['shop_open']['Monday'],
          data['shop_open']['Tuesday'],
          data['shop_open']['Wednesday'],
          data['shop_open']['Thursday'],
          data['shop_open']['Friday'],
          data['shop_open']['Saturday'],
          data['shop_open']['holiday'],
        ],
        closeTime = [
          data['shop_close']['Sunday'],
          data['shop_close']['Monday'],
          data['shop_close']['Tuesday'],
          data['shop_close']['Wednesday'],
          data['shop_close']['Thursday'],
          data['shop_close']['Friday'],
          data['shop_close']['Saturday'],
          data['shop_close']['holiday'],
        ];
}

class Evaluation {
  Evaluation({required this.id, required this.name, required this.value});

  final String id;
  final String name;
  final int value;
}
