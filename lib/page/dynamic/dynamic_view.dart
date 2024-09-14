import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dynamic_logic.dart';

class DynamicPage extends StatelessWidget {
  DynamicPage({Key? key}) : super(key: key);

  final logic = Get.put(DynamicLogic());
  final state = Get.find<DynamicLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DynamicPage')),
      body: Center(child: Text('DynamicPage', style: TextStyle(fontSize: 30.0))),
    );
  }

}
