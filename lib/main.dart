import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'model/shop.dart';
import 'ui/shop_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
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
        title: const Text('ケッチー（仮）'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('shop_list').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('エラーが発生しました');
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final shopList =
              snapshot.requireData.docs.map<Shop>((DocumentSnapshot document) {
            final data = document.data()! as Map<String, dynamic>;
            return Shop.fromMap(data);
          }).toList();

          return ShopList(shopList);
        },
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOKUHI（仮）'),
      ),
      body: ShopList(shopList),
    );
  }
}
