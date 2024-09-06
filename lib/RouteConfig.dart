

import 'package:flutterdemo/page/category/category_logic.dart';
import 'package:flutterdemo/page/home/home_logic.dart';
import 'package:flutterdemo/page/main/MyHomePage.dart';
import 'package:flutterdemo/page/mine/mine_logic.dart';
import 'package:flutterdemo/second/view.dart';
import 'package:flutterdemo/third/view.dart';
import 'package:flutterdemo/vebview/webview_page.dart';
import 'package:get/get.dart';

class RouteConfig {
  static const String home = "/home";
  static const String second = "/second";
  static const String third = "/third";
  static const String webview = "/webview";

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () => const MyHomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeLogic>(() => HomeLogic());
        Get.lazyPut<CategoryLogic>(() => CategoryLogic());
        Get.lazyPut<MineLogic>(() => MineLogic());
      }),
    ),
    GetPage(
      name: second,
      page: () => SecondPage(),
      // binding: TestOneBinding(),
    ),
    GetPage(
      name: third,
      page: () => ThirdPage(),
      // binding: TestTwoBinding(),
    ),
    GetPage(
      name: webview,
      page: () => const WebViewPage(),
    ),
  ];
}
