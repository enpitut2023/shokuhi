import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shokuhi/ui/shop_list.dart';
import 'package:shokuhi/utils/distance_between.dart';

import '../model/shop.dart';

class Home extends StatefulWidget {
  const Home(this.shopList, {super.key});
  final List<Shop> shopList;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LocationData? locationData;
  StreamSubscription<LocationData>? locationSubscription;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ここに任意のWidgetを書いて、緯度経度を渡すことでユーザーの位置情報をWidgetで利用できる。
    final longitude = locationData?.longitude;
    final latitude = locationData?.latitude;
    if (longitude != null && latitude != null) {
      return _Home(widget.shopList, longitude, latitude);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  void _getLocation() async {
    Location location = Location();
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1);

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('service is not enabled');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('permission is not granted');
      }
    }

    final tmp = await location.getLocation();
    setState(() {
      locationData = tmp;
    });

    locationSubscription = location.onLocationChanged.listen((event) {
      setState(() {
        locationData = event;
      });
    });
  }
}

class _Home extends StatefulWidget {
  const _Home(this.shopList, this.longitude, this.latitude, {super.key});

  final List<Shop> shopList;
  final double longitude;
  final double latitude;

  @override
  State<_Home> createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  var sortKey = '肉';
  var shopList = <Shop>[];
  @override
  void initState() {
    shopList = widget.shopList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOKUHI（仮）'),
        actions: [
          SortDropDownButton(sortKey, (String value) {
            setState(() {
              sortKey = value;
              shopList.sort((a, b) {
                if (sortKey == '距離') {
                  final d1 = distanceBetween(widget.latitude, widget.longitude,
                      a.latitude, a.longitude);
                  final d2 = distanceBetween(widget.latitude, widget.longitude,
                      b.latitude, b.longitude);
                  return d1.compareTo(d2);
                }
                final ev1 = a.evaluationList
                    .firstWhere((element) => element.name == sortKey);
                final ev2 = b.evaluationList
                    .firstWhere((element) => element.name == sortKey);
                return ev2.value.compareTo(ev1.value);
              });
            });
          }),
        ],
      ),
      body: ShopList(
        shopList,
        sortKey,
        longitude: widget.longitude,
        latitude: widget.latitude,
      ),
    );
  }
}

class SortDropDownButton extends StatelessWidget {
  const SortDropDownButton(this.sortKey, this.onChanged, {super.key});
  final String sortKey;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: sortKey,
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
      items: <String>['冷凍食品', '肉', '卵', '魚', '野菜', '距離']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 20)),
        );
      }).toList(),
    );
  }
}
