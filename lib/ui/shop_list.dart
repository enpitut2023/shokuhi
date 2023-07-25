import 'package:flutter/material.dart';
import 'package:shokuhi/utils/distance_between.dart';
import '../model/runnning.dart';
import '../model/shop.dart';
import 'shop_detail.dart';

class ShopList extends StatelessWidget {
  const ShopList(this.shopList, this.sortKey,
      {super.key, required this.longitude, required this.latitude});

  final String sortKey;
  final List<Shop> shopList;
  final double longitude;
  final double latitude;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final shop in shopList)
          ShopTile(
            sortKey,
            shop,
            longitude: longitude,
            latitude: latitude,
          ),
      ],
    );
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile(this.sortKey, this.shop,
      {super.key, required this.longitude, required this.latitude});

  final String sortKey;
  final Shop shop;
  final double longitude;
  final double latitude;

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = checkDayOfWeek();
    final openTime = shop.openTime[dayOfWeek];
    final closeTime = shop.closeTime[dayOfWeek];
    final running = checkRunning(openTime,closeTime);
    final distance =
        distanceBetween(latitude, longitude, shop.latitude, shop.longitude);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopDetail(shop),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Row(
              // タイトル + 営業時間
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(shop.name,
                      style: const TextStyle(
                          fontSize: 23,
                          fontFamily: 'Murecho',
                          color: Color(0xFF1a237e))),
                ),
                (running == '24時間営業') ? Text(running) : Text('${shop.openTime[dayOfWeek]} ~ ${shop.closeTime[dayOfWeek]}($running)'),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 評価
                    for (final evaluation in shop.evaluationList)
                      Row(children: [
                        SizedBox(
                          width: 100,
                          child: Text(evaluation.name),
                        ),
                        EvaluationWidget(
                            evaluation.value,
                            (sortKey == evaluation.name)
                                ? Colors.cyan
                                : Colors.cyan[100]!),
                      ]),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // その他の情報
                    Row(
                      children: [
                        const Icon(Icons.home),
                        Text(shop.address),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        Text(shop.telephoneNumber),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text(
                          '${(distance / 1000).toStringAsFixed(2)} km',
                          style: TextStyle(
                            color:
                                (sortKey == '距離') ? Colors.cyan : Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EvaluationWidget extends StatelessWidget {
  final int value;
  final Color color;

  const EvaluationWidget(this.value, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < value; i++) Icon(Icons.star, color: color),
        for (var i = value; i < 5; i++) Icon(Icons.star_border, color: color),
      ],
    );
  }
}
