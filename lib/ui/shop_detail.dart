import 'package:flutter/cupertino.dart';
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('タグ', style: TextStyle(fontSize: 20)),
            Row(
              children: [
                for (var tag in shop.tags)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
              ],
            )
          ],
        ));
  }
}
