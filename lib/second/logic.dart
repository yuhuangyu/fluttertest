import 'package:get/get.dart';

import '../RouteConfig.dart';
import 'state.dart';

class SecondLogic extends GetxController {
  final SecondState state = SecondState();

  jump() {
    // Get.toNamed(RouteConfig.third);
    Get.toNamed(RouteConfig.webview, arguments: {"url": "https://www.baidu.com/"});
  }
}
