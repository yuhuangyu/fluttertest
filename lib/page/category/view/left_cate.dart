// Flutter imports:
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterdemo/common/style/common_style.dart';
import 'package:flutterdemo/common/view/persistentHeader/sliver_header_builder.dart';
import 'package:flutterdemo/page/category/category_logic.dart';
import 'package:flutterdemo/page/category/category_state.dart';
import 'package:flutterdemo/page/home/home_logic.dart';
import 'package:flutterdemo/page/home/home_state.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


double itemHeight = 62.0;
Widget leftCate(BuildContext context, CategoryState state, CategoryLogic logic) {

  return Expanded(
    flex: 1,
    child: ListView.builder(
        // controller: state.scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          bool isSelect = logic.state.current.value.code == logic.state.categoryList.value[index].code;
          return Container(
            height: itemHeight,
            decoration: BoxDecoration(
              color: isSelect ? Colors.white : CommonStyle.greyBgColor3,
              // borderRadius: BorderRadius.only(bottomRight: Radius.circular(isPrev ? 20 : 0), topRight: Radius.circular(isNext ? 20 : 0)),
            ),
            child: Center(
              child: Text(logic.state.categoryList.value[index].name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          );
        },
      ),
  );
}