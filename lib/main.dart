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
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOKUHI（仮）'),
      ),
      body: ShopList(
        [
          Shop(name: 'ロピア', tags: ['肉が安い', '冷食が安い'], evaluation: Evaluation(3, 1, 2)),
          Shop(name: 'トライアル', tags: ['安そうで安い'], evaluation: Evaluation(3, 1, 2)),
          Shop(name: 'カスミ', tags: ['行ったことない'], evaluation: Evaluation(3, 1, 2)),
        ],
      ),
    );
  }
}
