import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_logic.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  final logic = Get.put(MyLogic());
  final state = Get.find<MyLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyPage')),
      body: Center(child: Text('MyPage', style: TextStyle(fontSize: 30.0))),
    );
  }
}
