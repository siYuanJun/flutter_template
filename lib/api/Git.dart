import 'package:flutter_template/common/HttpGo.dart';

class Git {
  getUserInfo() {
    return HttpGo.getInstance().get('/users/siYuanJun', {'id': 1});
  }
}