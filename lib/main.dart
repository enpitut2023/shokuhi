import 'package:flutter/material.dart';

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
      body: ShopList([
        Shop(name: 'ロピア', tags: ['肉が安い', '冷食が安い']),
        Shop(name: 'トライアル', tags: ['安そうで安い']),
        Shop(name: 'カスミ', tags: ['行ったことない']),
      ]),
    );
  }
}

class Shop {
  const Shop({required this.name, required this.tags});

  final String name;
  final List<String> tags;
}

class ShopList extends StatelessWidget {
  const ShopList(this.shopList, {super.key});
  final List<Shop> shopList;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var shop in shopList) ShopTile(shop),
      ]
    );
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile(this.shop, {super.key});
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(shop.name),
      subtitle: Row(
        children: [
          for (var tag in shop.tags) Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: Text(tag)
          )
        ],
      ),
    );
  }
}
