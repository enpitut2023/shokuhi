import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shokuhi/ui/shop_detail.dart';

import '../model/shop.dart';

class ShopMap extends StatelessWidget {
  const ShopMap(
      {super.key,
      required this.shopList,
      required this.userLongitude,
      required this.userLatitude});

  final double userLongitude;
  final double userLatitude;
  final List<Shop> shopList;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(userLatitude, userLongitude),
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
              point: LatLng(userLatitude, userLongitude),
              builder: (context) {
                return const Icon(Icons.location_on);
              },
            ),
            for (final shop in shopList)
              Marker(
                width: 100,
                height: 100,
                point: LatLng(shop.latitude, shop.longitude),
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopDetail(shop),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(shop.name),
                        const Icon(Icons.shop),
                      ],
                    ),
                  );
                },
              )
          ],
        )
      ],
    );
  }
}
