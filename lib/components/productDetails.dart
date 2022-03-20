import 'package:flutter/material.dart';
import 'package:flutter_template/model/ProductClass.dart';

class ProductDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    Product _product = arguments;

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("新闻详情"),
          ),
          body: Center(
            // child: Text("当前商品ID： ${_product.id}"),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "返回到上一页",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.of(context).pop({'id': _product.id});
          print("我退出了");
          return true;
        });
  }
}
