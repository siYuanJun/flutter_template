// 提供五套可选主题色
import 'package:flutter/material.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class GlobalConfig {
  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  static bool isDebug = true; // 是否是调试模式

  static bool dark = false;

  static Color fontColor = Colors.black54;

}
