import 'package:flutter/material.dart';
import 'package:shokuhi/ui/shop_list.dart';

import '../model/shop.dart';

class Home extends StatefulWidget {
  const Home(this.shopList, {super.key});

  final List<Shop> shopList;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var sortKey = '肉';
  var shopList = <Shop>[];
  @override
  void initState() {
    shopList = widget.shopList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOKUHI（仮）'),
        actions: [
          SortDropDownButton(
                  sortKey,
                  (String value){
            setState(() {
              sortKey = value;
              shopList.sort((a, b){
                final ev1 = a.evaluationList.firstWhere((element) => element.name == sortKey);
                final ev2 = b.evaluationList.firstWhere((element) => element.name == sortKey);
                return ev2.value.compareTo(ev1.value);
              });
            });
          }),
        ],
      ),
      body: ShopList(shopList),
    );
  }
}

class SortDropDownButton extends StatelessWidget {
  const SortDropDownButton(this.sortKey, this.onChanged, {super.key});
  final String sortKey;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: sortKey,
      onChanged: (String? newValue) {
        if (newValue != null) onChanged(newValue);
      },
      items: <String>['肉', '魚', '野菜', '冷凍食品', '卵']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 20)),
        );
      }).toList(),
    );
  }
}
