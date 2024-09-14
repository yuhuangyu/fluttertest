import 'package:get/get.dart';

import 'dynamic_state.dart';

class DynamicLogic extends GetxController {
  final DynamicState state = DynamicState();



  scrollToTop() {
    // if (scrollController.offset <= 0) {
    //   scrollController
    //       .animateTo(0,
    //       duration: const Duration(milliseconds: 600), curve: Curves.linear)
    //       .then((_) {
    //     showRefreshLoading();
    //   });
    // } else {
    //   scrollController.animateTo(0,
    //       duration: const Duration(milliseconds: 600), curve: Curves.linear);
    // }
  }
}
