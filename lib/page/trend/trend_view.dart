import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trend_logic.dart';

class TrendPage extends StatelessWidget {
  TrendPage({Key? key}) : super(key: key);

  final logic = Get.put(TrendLogic());
  final state = Get.find<TrendLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Center(child: Container());
  }
}
