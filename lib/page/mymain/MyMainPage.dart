import 'dart:io';

// import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/common/image/asset_image.dart';
import 'package:flutterdemo/common/style/gsy_style.dart';
import 'package:flutterdemo/common/view/gsy_tabbar_widget.dart';
import 'package:flutterdemo/common/view/gsy_title_bar.dart';
import 'package:flutterdemo/generated/assets.dart';
import 'package:flutterdemo/page/dynamic/dynamic_logic.dart';
import 'package:flutterdemo/page/dynamic/dynamic_state.dart';
import 'package:flutterdemo/page/dynamic/dynamic_view.dart';
import 'package:flutterdemo/page/my/my_view.dart';
import 'package:flutterdemo/page/mymain/home_drawer.dart';
import 'package:flutterdemo/page/trend/trend_view.dart';
import 'package:get/get.dart';

/// 主页
/// Created by guoshuyu
/// Date: 2018-07-16
/// 

class MyMainpagePage extends StatefulWidget {
  static const String sName = "home";

  const MyMainpagePage({super.key});

  @override
  _MyMainpagePageState createState() => _MyMainpagePageState();
}

class _MyMainpagePageState extends State<MyMainpagePage> {

  /// 不退出
  _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
  }

  _renderTab(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[assetImage(icon, 16, 16), Text(text)],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(Assets.imagesIcHome, "home_dynamic".tr),
      _renderTab(Assets.imagesIcCategory, "home_trend".tr),
      _renderTab(Assets.imagesIcMine, "home_my".tr),
    ];
    var dynamicPage = DynamicPage();
    var trendPage = TrendPage();
    var myPage = MyPage();
    ///增加返回按键监听
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (didPop, _) {
      //   _dialogExitApp(context);
      // },
      child: GSYTabBarWidget(
        drawer: const HomeDrawer(),
        type: TabType.bottom,
        tabItems: tabs,
        tabViews: [
          dynamicPage,
          trendPage,
          myPage,
        ],
        onDoublePress: (index) {
          switch (index) {
            case 0:
              dynamicPage.logic.scrollToTop();
              break;
            case 1:
              trendPage.logic.scrollToTop();
              break;
            case 2:
              myPage.logic.scrollToTop();
              break;
          }
        },
        backgroundColor: GSYColors.primarySwatch,
        indicatorColor: GSYColors.white,
        title: GSYTitleBar(
          "appName".tr,
          iconData: GSYICons.MAIN_SEARCH,
          needRightLocalIcon: true,
          onRightIconPressed: (centerPosition) {
            // NavigatorUtils.goSearchPage(context, centerPosition);
          },
        ),
      ),
    );
  }
}
