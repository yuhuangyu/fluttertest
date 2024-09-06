import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'mine_logic.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});

  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mine')),
      body: Column(
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            color: Colors.blue,
          ),
          Container(
            margin: EdgeInsets.only(top: 120.w),
            width: 120.w,
            height: 120.w,
            color: Colors.red,
          ),
          // Center(child: Text('Mine', style: TextStyle(fontSize: 30.0.sp))),
        ],
      )

    );
  }
}
