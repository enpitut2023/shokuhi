import 'package:flutter/material.dart';

import '../model/shop.dart';

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
                    Row(children: [
                      const SizedBox(
                        width: 100,
                        child: Text('肉'),
                      ),
                      EvaluationWidget(shop.evaluation.meat)
                    ]),
                    Row(children: [
                      const SizedBox(
                        width: 100,
                        child: Text('魚'),
                      ),
                      EvaluationWidget(shop.evaluation.fish)
                    ]),
                    Row(children: [
                      const SizedBox(
                        width: 100,
                        child: Text('野菜'),
                      ),
                      EvaluationWidget(shop.evaluation.vegetable)
                    ]),
                    Row(children: [
                      const SizedBox(
                        width: 100,
                        child: Text('冷食'),
                      ),
                      EvaluationWidget(shop.evaluation.frozenFood)
                    ]),
                    Row(children: [
                      const SizedBox(
                        width: 100,
                        child: Text('卵・乳製品'),
                      ),
                      EvaluationWidget(shop.evaluation.dairy)
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
                    for (final tag in shop.tags)
                      TextButton(onPressed: () {}, child: Text(tag)),
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
  const EvaluationWidget(this.evaluation, {super.key});

  final int evaluation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < evaluation; i++)
          const Icon(Icons.star, color: Colors.yellow),
        for (var i = evaluation; i < 5; i++)
          const Icon(Icons.star_border, color: Colors.yellow),
      ],
    );
  }
}
