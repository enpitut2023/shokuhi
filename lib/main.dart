
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'model/shop.dart';
import 'ui/shop_list.dart';

Map<String, String> evaluationList = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance
      .collection('evaluation_list') // evaluationsのサブコレクションを指定
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, String> evaluationList = {};

      final documents = querySnapshot.docs;
      for (var document in documents){
        final data = document.data();
        evaluationList[document.id] = data['name'];
      }

      runApp(MyApp(evaluationList));

    } else {
      print('サブコレクションは空です。');
    }
  }).catchError((error) {
    print('サブコレクションの取得中にエラーが発生しました: $error');
  });
}

class MyApp extends StatelessWidget {
  const MyApp(this.evaluationList,{super.key});

  final Map<String, String> evaluationList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(evaluationList),
    );
  }
}

class Home extends StatelessWidget {
  const Home(this.evaluationList,{super.key});

  final Map<String, String> evaluationList;

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

            Future<List<Shop>> getShops() async {
              final docs = snapshot.requireData.docs;

              return await Future.wait(docs.map<Future<Shop>>((DocumentSnapshot document) async {
                final data = document.data()! as Map<String, dynamic>;
                final id = document.id;
                return Shop.fromMap(data, await getEvaluations(id));
              }).toList());
            }

            return FutureBuilder<List<Shop>>(
              future: getShops(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                }

                return ShopList(
                    snapshot.data as List<Shop>
                );
              },
            );
          },
        )
    );
  }

  Future<List<Evaluation>> getEvaluations(String docId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shop_list')
          .doc(docId)
          .collection('evaluations')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final evaluationDocuments = querySnapshot.docs;
        List<Evaluation> evaluations = [];
        for (var evaluationDocument in evaluationDocuments) {
          final String evaluationId = evaluationDocument.id;
          final int evaluationValue = evaluationDocument.get('value');
          final evaluationName = evaluationList[evaluationId];
          if(evaluationName == null){
            throw('nullです．');
          }
          evaluations.add(Evaluation(
            id: evaluationId,
            name: evaluationName,
            value: evaluationValue,
          ));
        }
        return evaluations;
      } else {
        throw Exception('サブコレクションは空です．');
      }
    } catch (error) {
      throw Exception('サブコレクションの取得中にエラーが発生しました: $error');
    }
  }

}