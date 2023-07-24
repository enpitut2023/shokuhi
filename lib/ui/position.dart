import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' ;

/// デバイスの現在位置を決定する。
/// 位置情報サービスが有効でない場合、または許可されていない場合。
/// エラーを返します



Future<void> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // 位置情報サービスが有効かどうかをテストします。
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // 位置情報サービスが有効でない場合、続行できません。
    // 位置情報にアクセスし、ユーザーに対して
    // 位置情報サービスを有効にするようアプリに要請する。
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // ユーザーに位置情報を許可してもらうよう促す
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // 拒否された場合エラーを返す
      return Future.error('Location permissions are denied');
    }
  }

  // 永久に拒否されている場合のエラーを返す
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // 位置情報に対しての権限が許可されているということなので
  // デバイスの位置情報を返す。

  final position = await Geolocator.getCurrentPosition();

// 取得した位置情報の経度と緯度を使い、詳細情報を取り出す
  debugPrint(position.latitude.toString());
  debugPrint(position.longitude.toString());
  final placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

// 上記のplaceMarksは配列で帰ってくるので一つだけ取り出す
  final placeMark = placeMarks[0];

// 出力してみる
  debugPrint(placeMark.country); // 国が取得できます
  debugPrint(placeMark.administrativeArea); // 県が取得できます(日本の場合)
  debugPrint(placeMark.locality); // 市が取得できます(日本の場合)
}





