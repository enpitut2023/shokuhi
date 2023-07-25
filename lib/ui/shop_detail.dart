import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import '../model/shop.dart';

class ShopDetail extends StatelessWidget {
  const ShopDetail(this.shop, {super.key});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.name),
      ),
      body: MapWidget(shop.longitude, shop.latitude),
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget(this.longitude, this.latitude, {super.key});

  final double longitude;
  final double latitude;

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 営業時間を表示
                    Text('営業時間'),
                    SizedBox(height: 4),
                    for (var widget
                    in buildOpeningHoursWidgets(shop.openTime, shop.closeTime))
                      widget,
                    SizedBox(height: 16),
                    // 電話番号を表示
                    Text('電話番号'),
                    SizedBox(height: 4),
                    Text(shop.telephoneNumber),
                    SizedBox(height: 16),
                    // 住所を表示
                    Text('住所'),
                    SizedBox(height: 4),
                    Text(shop.address),
                  ],
                ), //ここにマップを追加する
              ],
            ),
            const Text('評価'),

            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularNumberWidget(number: 5)
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 営業時間のウィジェットを生成するメソッド
  List<Widget> buildOpeningHoursWidgets(List<String> openTime,
      List<String> closeTime) {
    const daysOfWeek = ['月', '火', '水', '木', '金', '土', '日'];
    List<Widget> openingHoursWidgets = [];
    for (int i = 0; i < openTime.length; i++) {
      final open = openTime[i];
      final close = closeTime[i];
      final day = daysOfWeek[i];
      openingHoursWidgets.add(
        Text('$day: $open 〜 $close'),
      );
    }
    return openingHoursWidgets;
  }
}

class CircularNumberWidget extends StatelessWidget {
  final int number;
  final double size;
  final Color color;

  const CircularNumberWidget({super.key,
    required this.number,
    this.size = 100.0,
    this.color = Colors.blue,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
        '$number',
          style: const TextStyle(
          fontSize: 30,
          color: Colors.white,
          ),
        ),
      ),
    );
  }
}
