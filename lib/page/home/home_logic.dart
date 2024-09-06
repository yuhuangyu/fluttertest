
import 'dart:ui';

import 'package:flutterdemo/http/common_service.dart';
import 'package:flutterdemo/http/service.dart';
import 'package:get/get.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  @override
  void onInit() {
    initPageData();
    super.onInit();
  }

  @override
  void onClose() {
    state.freshController.dispose();
    state.scrollController.dispose();
    state.pageController.dispose();
    super.onClose();
  }

  initPageData() async {
    state.isLoading.value = true;
    var info = await HApi.queryHomeInfo();
    state.isLoading.value = false;
    state.homePageInfo.value = info;
  }

  refreshPage(VoidCallback freshSuccess, VoidCallback freshFail) async {
    var info = await HApi.queryHomeInfo();
    if (info != null) {
      state.homePageInfo.value = info;
      freshSuccess();
    } else {
      freshFail();
    }
  }

  changeCurrentTab(String va) => state.currentTab.value = va;
  setIsTabClick(bool va) => state.isTabClick.value = va;

}
