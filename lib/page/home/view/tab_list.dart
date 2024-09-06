// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutterdemo/common/style/common_style.dart';
import 'package:flutterdemo/common/view/persistentHeader/sliver_header_builder.dart';
import 'package:flutterdemo/page/home/home_logic.dart';
import 'package:flutterdemo/page/home/home_state.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


Widget tabList(BuildContext context, HomeState state, HomeLogic logic) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate.fixedHeight(
      //固定高度
      height: 54,
      child: Container(
        color: CommonStyle.greyBgColor,
        child: Obx(() {
          var tabs = state.homePageInfo.value.tabList ?? [];
          int totalCount = tabs.length;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: totalCount,
            itemExtent: 84.0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => {
                  logic.setIsTabClick(true),
                  state.currentTab(tabs[index].code!),
                  state.pageController
                      .animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear)
                      .then((value) => logic.setIsTabClick(false))
                },
                child: Obx(() {
                  String currentTab = state.currentTab.value.isNotEmpty
                      ? state.currentTab.value
                      : tabs.isNotEmpty
                          ? tabs[0].code!
                          : "";
                  bool isSelect = currentTab == tabs[index].code;

                  return Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 84,
                          color: CommonStyle.greyBgColor,
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            tabs[index].name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelect ? CommonStyle.selectedTabColor : CommonStyle.unSelectedTabColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 2,
                        decoration: BoxDecoration(
                          color: isSelect ? CommonStyle.selectedTabColor : CommonStyle.greyBgColor,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      Container(width: 20, height: 12, color: Colors.transparent),
                    ],
                  );
                }),
              );
            },
          );
        }),
      ),
    ),
  );
}
