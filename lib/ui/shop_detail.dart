import 'package:flutter/material.dart';

import '../model/shop.dart';

class ShopDetail extends StatelessWidget {
  const ShopDetail(this.shop, {super.key});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.name),
      ),
      body: ShopDetailBody(shop),
    );
  }
}

class ShopDetailBody extends StatelessWidget {
  const ShopDetailBody(this.shop, {super.key});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 営業時間を表示
        Text('営業時間'),
        SizedBox(height: 4),
        for (var widget
            in buildOpeningHoursWidgets(shop.openTime, shop.closeTime))
          widget,
        SizedBox(height: 16),
        // 電話番号を表示
        Text('電話番号'),
        SizedBox(height: 4),
        Text(shop.telephoneNumber),
        SizedBox(height: 16),
        // 住所を表示
        Text('住所'),
        SizedBox(height: 4),
        Text(shop.address),
      ],
    );

    // return GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => ShopDetail(shop),
    //       ),
    //     );
    //   },
    //   child: Card(
    //     child: Column(
    //       children: [
    //         Row(
    //           // タイトル + 営業時間
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(shop.name,
    //                 style: const TextStyle(
    //                     fontSize: 23,
    //                     fontFamily: 'Murecho',
    //                     color: Color(0xFF1a237e))),
    //             Text('$openTime ~ $closeTime'),
    //           ],
    //         ),
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 // 評価
    //                 for (final evaluation in shop.evaluationList)
    //                   Row(children: [
    //                     SizedBox(
    //                       width: 100,
    //                       child: Text(evaluation.name),
    //                     ),
    //                     EvaluationWidget(evaluation.value, (sortKey == evaluation.name) ? Colors.cyan : Colors.cyan[100]!),
    //                   ]),
    //               ],
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.end,
    //               children: [
    //                 // その他の情報
    //                 Row(
    //                   children: [
    //                     const Icon(Icons.home),
    //                     Text(shop.address),
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     const Icon(Icons.phone),
    //                     Text(shop.telephoneNumber),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  //}
  }

  // 営業時間のウィジェットを生成するメソッド
  List<Widget> buildOpeningHoursWidgets(
      List<String> openTime, List<String> closeTime) {
    const daysOfWeek = ['月', '火', '水', '木', '金', '土', '日'];
    List<Widget> openingHoursWidgets = [];
    for (int i = 0; i < openTime.length; i++) {
      final open = openTime[i];
      final close = closeTime[i];
      final day = daysOfWeek[i];
      openingHoursWidgets.add(
        Text('$day: $open 〜 $close'),
      );
    }
    return openingHoursWidgets;
  }
}
