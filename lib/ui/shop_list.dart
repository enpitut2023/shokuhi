import 'package:flutter/material.dart';

import '../model/shop.dart';
import 'shop_detail.dart';


class ShopList extends StatelessWidget {
  const ShopList(this.shopList, {super.key});

  final List<Shop> shopList;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      for (var shop in shopList) ShopTile(shop),
    ]);
  }
}

class ShopTile extends StatelessWidget {
  const ShopTile(this.shop, {super.key});

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(shop.name),
      subtitle: Row(
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
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopDetail(shop),
          ),
        );
      },
    );
  }
}
