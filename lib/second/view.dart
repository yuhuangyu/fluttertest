import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key}) : super(key: key);

  final logic = Get.put(SecondLogic());
  final state = Get.find<SecondLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('页面二')),
      body: Center(child: Text('页面二', style: TextStyle(fontSize: 30.0))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.jump(),
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
