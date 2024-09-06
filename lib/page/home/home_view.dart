import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/page/home/view/adv_img.dart';
import 'package:flutterdemo/page/home/view/gallery_list.dart';
import 'package:flutterdemo/page/home/view/keep_alive_wrapper.dart';
import 'package:flutterdemo/page/home/view/menu_slider.dart';
import 'package:flutterdemo/page/home/view/page_goods_list.dart';
import 'package:flutterdemo/page/home/view/search_header.dart';
import 'package:flutterdemo/page/home/view/tab_list.dart';
import 'package:get/get.dart';
import '../../util/easy_refresh_util.dart';
import '../../util/refresh_util.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      controller: state.freshController,
      header: classicHeader,
      clipBehavior: Clip.none,
      onRefresh: () => logic.refreshPage(
        () => easyRefreshSuccess(state.freshController),
        () => easyRefreshFail(state.freshController),
      ),
      childBuilder: (context, physics) {
        return Scaffold(
          body: ExtendedNestedScrollView(
            controller: state.scrollController,
            // pinnedHeaderSliverHeightBuilder: () {
            //   return statusHeight + 44 + 54;
            // },
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const HeaderLocator.sliver(clearExtent: false),
                searchHeader(context, state.pageScrollY),
                //Flutter轮播组件
                galleryList(context, state.homePageInfo),
                advBanner(context, state.homePageInfo),
                menuSlider(context, state.homePageInfo),
                tabList(context, state, logic)
              ];
            },
            onlyOneScrollInBody: true,
            body: Obx(() {
              var tabs = state.homePageInfo.value.tabList ?? [];
              String selectTab = state.currentTab.value;
              String currentTab = selectTab.isNotEmpty
                  ? selectTab
                  : tabs.isNotEmpty
                      ? tabs[0].code!
                      : "";

              return PageView(
                controller: state.pageController,
                onPageChanged: (index) {
                  if (state.isTabClick.value) return;
                  logic.changeCurrentTab(tabs[index].code!);
                },
                children: tabs
                    .map((e) => KeepAliveWrapper(
                        child: PageGoodsList(
                            "home_tab_${e.code!}", currentTab, physics)))
                    .toList(),
              );
            }),
          ),
          // floatingActionButton: Obx(() => backTop(state.showBackTop.value, state.scrollController)),
        );
      },
    );
  }
}
