// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutterdemo/page/home/been/home_page_info.dart';
import 'package:flutterdemo/page/home/been/mine_menu_tab_info.dart';
import 'package:flutterdemo/page/home/view/page_menu.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:

Widget menuSlider(BuildContext context, Rx<HomePageInfo> homePageInfo) {
  return SliverToBoxAdapter(
    child: Obx(() {
      List<NineMenuList> nineMenuList = homePageInfo.value.nineMenuList ?? [];
      List<FunctionInfo> menuData = nineMenuList
          .map((e) => FunctionInfo(
                menuIcon: e.menuIcon,
                menuCode: e.menuCode,
                menuName: e.menuName,
                h5url: e.h5url,
              ))
          .toList();

      return PageMenu(
        menuDataList: menuData,
        rowCount: 2,
      );
    }),
  );
}
