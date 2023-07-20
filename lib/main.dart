import 'package:flutter/material.dart';

import 'model/shop.dart';
import 'ui/shop_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHOKUHI（仮）',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    final shopList = [
      Shop(
        name: 'ロピア',
        tags: ['肉が安い', '冷食が安い'],
        address: '春日らへん',
        telephoneNumber: '0120-107-929',
        openTime: [DateTime.utc(0,0,0,9,0)],
        closeTime: [DateTime.utc(0,0,0,19,0)],
        evaluation: Evaluation(
          meat: 1,
          fish: 2,
          vegetable: 3,
          frozenFood: 4,
          dairy: 5,
        ),
      ),
      Shop(
        name: 'トライアル',
        tags: ['野菜が安い', '肉が安い'],
        address: '学園の森',
        telephoneNumber: '0120-',
        openTime: [DateTime.utc(0,0,0,9,0)],
        closeTime: [DateTime.utc(0,0,0,19,0)],
        evaluation: Evaluation(
          meat: 5,
          fish: 4,
          vegetable: 3,
          frozenFood: 2,
          dairy: 1,
        ),
      ),
      Shop(
        name: 'カスミ',
        tags: ['卵が安い', '冷食が安い'],
        address: '平砂',
        telephoneNumber: '',
        openTime: [DateTime.utc(0,0,0,9,0)],
        closeTime: [DateTime.utc(0,0,0,19,0)],
        evaluation: Evaluation(
          meat: 2,
          fish: 2,
          vegetable: 2,
          frozenFood: 2,
          dairy: 2,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOKUHI（仮）'),
      ),
      body: ShopList(shopList),
    );
  }
}
