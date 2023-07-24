import 'dart:math';

import 'package:flutter/material.dart';

import '../model/shop.dart';
import 'shop_detail.dart';

class ShopList extends StatelessWidget {
  const ShopList(this.shopList, {super.key});

  final List<Shop> shopList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final shop in shopList)
          ShopTile(
            shop,
          ),
      ],
    );
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile(this.shop, {super.key});

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
                        EvaluationWidget(evaluation.value),
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

  const EvaluationWidget(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < value; i++)
          const Icon(Icons.star, color: Colors.yellow),
        for (var i = value; i < 5; i++)
          const Icon(Icons.star_border, color: Colors.yellow),
      ],
    );
  }
}
