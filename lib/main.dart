import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'model/shop.dart';
import 'ui/shop_list.dart';

void main() async {
  runApp(const MyApp());
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
      body: ShopList(
        [
          Shop(name: 'カスミ学園店', evaluationList: [Evaluation(id: '1', name: 'name', value: 3)], address:'茨城県つくば市天久保３丁目２ー１', telephoneNumber: '０２９ー１２３４ー５６７８', openTime: ['１０；００'], closeTime: ['２０:００']),
          Shop(name: 'トライアル', evaluationList: [Evaluation(id: '1', name: 'name', value: 4)], address:'茨城県つくば市学園の森３丁目２ー１', telephoneNumber: '０２９ー１２３４ー５６７８', openTime: ['９；００'], closeTime: ['２４:００'])

        ]
      )
    );
  }
}
