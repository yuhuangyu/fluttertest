import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterdemo/http/service.dart';
import 'package:flutterdemo/page/category/been/category_list_entity.dart';
import 'package:get/get.dart';

import 'been/second_group_category_info.dart';
import 'category_state.dart';

class CategoryLogic extends GetxController {
  final CategoryState state = CategoryState();

  @override
  void onInit() {
    initPageData();
    super.onInit();
  }

  //加载页面数据
  initPageData() async {
    state.isLoading.value = true;
    CategoryListEntity res = await HApi.queryCategoryInfo();
    List<CategoryInfo> list = res.categoryList ?? [];
    if (list.isNotEmpty) {
      //一级分类列表
      state.categoryList.value = list;

      //设置默认选中的一级分类
      state.current.value = list[0];
      state.previous.value = CategoryInfo.fromJson({});
      state.next.value = list[1];

      //请求二三级分类信息
      await getSecondInfo(list[0]);
    } else {
      state.isLoading.value = false;
    }
  }

  Future<void> getSecondInfo(CategoryInfo categoryInfo) async {
    // state.isLoading.value = true;
    SecondGroupCategoryInfo info = await HApi.querySecondGroupCategoryInfo(categoryInfo.code!);
    state.isLoading.value = false;
    SecondCateList selectSecondCateInfo = info.secondCateList!.isNotEmpty ? info.secondCateList![0] : SecondCateList.fromJson({});

    //二三级分类信息分组列表
    state.secondGroupCategoryInfo.value = info;
    //二级分类默认选中
    state.selectSecondCategoryInfo.value = selectSecondCateInfo;
  }

  void setCurrent(CategoryInfo item, int index) async {
    //设置选中的一级分类
    List<CategoryInfo> list = state.categoryList.value;

    state.current.value = item;
    state.previous.value = index-1<0 ? CategoryInfo.fromJson({}) : list[index-1];
    state.next.value = index+1<list.length ? list[index+1] : CategoryInfo.fromJson({});

    //请求二三级分类信息
    await getSecondInfo(item);
  }

  void setCurrentselect(SecondCateList secondCateList, BuildContext? currentContext, BuildContext? currentContextSecond) {
    state.selectSecondCategoryInfo.value = secondCateList;
    //滚动三级分类
    RenderSliverToBoxAdapter? keyRenderObject = currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
    if (keyRenderObject != null) {
      state.gridViewController.position
          .ensureVisible(keyRenderObject, duration: const Duration(milliseconds: 300), curve: Curves.linear)
          .then((value) => state.setTabClicked(false));
    }
  }



  @override
  void onClose() {
    state.scrollController.dispose();
    state.rightScrollController.dispose();
    state.gridViewController.dispose();
    super.onClose();
  }
}
