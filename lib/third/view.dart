import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ThirdPage extends StatelessWidget {
  ThirdPage({Key? key}) : super(key: key);

  final logic = Get.put(ThirdLogic());
  final state = Get.find<ThirdLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('页面三')),
      body: Center(child: Text('页面三', style: TextStyle(fontSize: 30.0))),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => logic.jump(),
      //   child: Icon(Icons.arrow_forward),
      // ),
    );
  }
}
