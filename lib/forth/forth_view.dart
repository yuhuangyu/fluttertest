import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forth_logic.dart';

class ForthPage extends StatelessWidget {
  ForthPage({Key? key}) : super(key: key);

  final logic = Get.put(ForthLogic());
  final state = Get.find<ForthLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
