import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'model/shop.dart';
import 'ui/shop_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
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

          // TODO: ここでshopListを作る
          final shopList =
              snapshot.requireData.docs.map<Shop>((DocumentSnapshot document) {
            final data = document.data()! as Map<String, dynamic>;
            // TODO: 取得したデータをShopに変換する
            return Shop(
              name: data['shop_name'],
              tags: ['tag1', 'tag2'],
              evaluation: Evaluation(
                meat: 0,
                fish: 0,
                vegetable: 0,
                frozenFood: 0,
                dairy: 0,
              ),
              address: data['shop_address'],
              telephoneNumber: data['shop_tel'],
              openTime: [
                data['shop_open']['Sunday'],
                data['shop_open']['Monday'],
                data['shop_open']['Tuesday'],
                data['shop_open']['Wednesday'],
                data['shop_open']['Thursday'],
                data['shop_open']['Friday'],
                data['shop_open']['Saturday'],
              ],
              closeTime: [
                data['shop_close']['Sunday'],
                data['shop_close']['Monday'],
                data['shop_close']['Tuesday'],
                data['shop_close']['Wednesday'],
                data['shop_close']['Thursday'],
                data['shop_close']['Friday'],
                data['shop_close']['Saturday'],
              ],
            );
          }).toList();

          return ShopList(shopList);
        },
      ),
    );
  }
}
