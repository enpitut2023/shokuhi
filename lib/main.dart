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
        title: const Text(String.fromEnvironment("netlify_iosBundleId")),
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
      ),
    );
  }
}