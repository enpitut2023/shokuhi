import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
      body: ShopDetailBody(shop),
    );
  }
}

class ShopDetailBody extends StatelessWidget {
  const ShopDetailBody(this.shop, {super.key});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 営業時間を表示
                  Text('営業時間',
                      style: Theme.of(context).textTheme.headlineMedium),
                  buildOpeningHoursWidgets(shop.openTime, shop.closeTime),
                  // 電話番号を表示
                  Text('電話番号',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(shop.telephoneNumber),
                  // 住所を表示
                  Text('住所', style: Theme.of(context).textTheme.headlineMedium),
                  Text(shop.address),
                ],
              ), //ここにマップを追加する
              SizedBox(
                width: min(size.width / 2.5, 300.0),
                height: min(size.width / 2.5, 300.0),
                child: MapWidget(shop.longitude, shop.latitude),
              ),
            ],
          ),
          Text(
            '評価',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final evaluation in shop.evaluationList)
                Column(
                  children: [
                    CircularEvaluationWidget(
                      name: evaluation.name,
                      number: evaluation.value,
                      size: min(size.width / (shop.evaluationList.length + 1), 200),
                      image: const AssetImage('images/肉.png'),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  // 営業時間のウィジェットを生成するメソッド
  Widget buildOpeningHoursWidgets(
      List<String> openTime, List<String> closeTime) {
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
    return Column(children: [for (final widget in openingHoursWidgets) widget]);
  }
}

class CircularEvaluationWidget extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final String name;
  final ImageProvider? image;

  const CircularEvaluationWidget({
    super.key,
    required this.number,
    required this.name,
    this.image,
    this.size = 100.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: Theme.of(context).textTheme.headlineSmall),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: (image != null) ? DecorationImage(image: image!, opacity: 0.45) : null,
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget(this.longitude, this.latitude, {super.key});

  final double longitude;
  final double latitude;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latitude, longitude),
        zoom: 15.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(latitude, longitude),
              builder: (context) {
                return const Icon(Icons.location_on);
              },
            )
          ],
        )
      ],
    );
  }
}
