import 'package:flutter/material.dart';

//------------------------- TapboxB ----------------------------------

class Temp extends StatelessWidget {
  const Temp({Key? key, this.active: false, required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _handleTap,
          child: Container(
            child: Text(
              active ? 'Active' : 'Inactive',
              style: const TextStyle(fontSize: 32.0, color: Colors.white),
            ),
            width: 750,
            height: 100.0,
            decoration: BoxDecoration(
              color: active ? Colors.lightGreen[700] : Colors.grey[600],
            ),
          ),
        ),
        RaisedButton(
          child: Text('切换'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('提示'),
                    content: Text('确认删除吗？'),
                    actions: <Widget>[
                      FlatButton(child: Text('取消'), onPressed: () {}),
                      FlatButton(
                        child: Text('确认'),
                        onPressed: () {},
                      ),
                    ],
                  );
                });
          },
        )
      ],
    );
  }
}
