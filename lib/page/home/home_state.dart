import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'been/home_page_info.dart';

class HomeState {
  HomeState() {
    ///Initialize variables
  }

  final EasyRefreshController freshController = EasyRefreshController(controlFinishRefresh: true);
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  //首页数据
  Rx<HomePageInfo> homePageInfo = HomePageInfo.fromJson({}).obs;

  RxString currentTab = "".obs;
  RxBool isTabClick = false.obs;
  RxBool isLoading = true.obs;
  RxDouble pageScrollY = 0.0.obs;


}
