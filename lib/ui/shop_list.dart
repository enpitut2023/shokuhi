import 'package:flutter/material.dart';

import '../model/shop.dart';
import 'shop_detail.dart';

class ShopList extends StatelessWidget {
  const ShopList(this.shopList, this.sortKey, {super.key});

  final String sortKey;
  final List<Shop> shopList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final shop in shopList)
          ShopTile(
            sortKey,
            shop,
          ),
      ],
    );
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile(this.sortKey, this.shop, {super.key});

  final String sortKey;
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    final openTime = shop.openTime[0];
    final closeTime = shop.closeTime[0];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopDetail(shop),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Row(
              // タイトル + 営業時間
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(shop.name,
                    style: const TextStyle(
                        fontSize: 23,
                        fontFamily: 'Murecho',
                        color: Color(0xFF1a237e))),
                Text('$openTime ~ $closeTime'),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 評価
                    for (final evaluation in shop.evaluationList)
                      Row(children: [
                        SizedBox(
                          width: 100,
                          child: Text(evaluation.name),
                        ),
                        EvaluationWidget(evaluation.value, (sortKey == evaluation.name) ? Colors.cyan : Colors.cyan[100]!),
                      ]),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // その他の情報
                    Row(
                      children: [
                        const Icon(Icons.home),
                        Text(shop.address),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        Text(shop.telephoneNumber),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EvaluationWidget extends StatelessWidget {
  final int value;
  final Color color;

  const EvaluationWidget(this.value, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < value; i++) Icon(Icons.star, color: color),
        for (var i = value; i < 5; i++) Icon(Icons.star_border, color: color),
      ],
    );
  }
}
