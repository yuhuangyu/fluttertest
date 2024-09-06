import 'package:flutter/widgets.dart';
import 'package:flutterdemo/page/category/been/category_list_entity.dart';
import 'package:flutterdemo/page/category/been/second_group_category_info.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CategoryState {
  CategoryState() {
    ///Initialize variables
  }
  final ScrollController scrollController = ScrollController();
  final ScrollController rightScrollController = ScrollController();
  final ScrollController gridViewController = ScrollController();

  RxBool isLoading = true.obs;

  //左侧一级分类默认选中信息
  Rx<CategoryInfo> previous = CategoryInfo.fromJson({}).obs;
  Rx<CategoryInfo> current = CategoryInfo.fromJson({}).obs;
  Rx<CategoryInfo> next = CategoryInfo.fromJson({}).obs;


  RxBool isTabClicked = false.obs;
  // RxBool isSelect = false.obs;

  //左侧一级分类列表
  RxList<CategoryInfo> categoryList = <CategoryInfo>[].obs;

  //二三级分类信息分组列表
  Rx<SecondGroupCategoryInfo> secondGroupCategoryInfo = SecondGroupCategoryInfo.fromJson({}).obs;

  //二级分类默认选中的信息
  Rx<SecondCateList> selectSecondCategoryInfo = SecondCateList.fromJson({}).obs;



  setTabClicked(bool va) => isTabClicked.value = va;
}
