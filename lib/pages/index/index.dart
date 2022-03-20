import 'package:flutter/material.dart';
import 'package:flutter_template/api/Git.dart';
import 'package:flutter_template/components/Temp.dart';
import 'package:flutter_template/model/ProductClass.dart';

class IndexWidget extends StatefulWidget {
  const IndexWidget({Key? key}) : super(key: key);

  @override
  _IndexWidgetState createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<IndexWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      print(_active);
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("首页")),
        body: Column(
          children: [
            TextButton(onPressed: () async {
              var res = await Git().getUserInfo();
              print("222: " + res.toString());
            }, child: const Text('获取Github')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("route-login");
                },
                child: const Text("登录",
                    style: (TextStyle(color: Colors.black87, fontSize: 30)))),
            Temp(
              active: _active,
              onChanged: _handleTapboxChanged,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("route-product-details",
                      arguments: Product(10010));
                },
                child: const Text(
                  "商品详情",
                  style: (TextStyle(color: Colors.black87, fontSize: 30)),
                )),
          ],
        ));
  }
}
