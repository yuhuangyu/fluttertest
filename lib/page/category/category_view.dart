import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdemo/common/image/asset_image.dart';
import 'package:flutterdemo/common/style/common_style.dart';
import 'package:flutterdemo/generated/assets.dart';
import 'package:flutterdemo/page/category/been/category_list_entity.dart';
import 'package:flutterdemo/page/category/been/second_group_category_info.dart';
import 'package:flutterdemo/util/screen_util.dart';
import 'package:flutterdemo/vebview/loading_widget.dart';
import 'package:get/get.dart';
import 'category_logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);

  final logic = Get.put(CategoryLogic());
  final state = Get.find<CategoryLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return state.isLoading.value
          ? loadingWidget(context)
          : Flex(
              direction: Axis.horizontal,
              children: [
                // LeftListView(categoryList: state.categoryList.value, current: state.current.value, onItemClick: (item, index){
                //   logic.setCurrent(item);
                // }),
                leftCate(context),
                rightGroup(context),
              ],
            );
    });
  }

  Widget leftCate(BuildContext context) {
    double itemHeight = 62.0;
    return Expanded(
      flex: 1,
      child: Obx(() {
        CategoryInfo current = state.current.value;
        CategoryInfo previous = state.previous.value;
        CategoryInfo next = state.next.value;

        List<CategoryInfo> categoryList = state.categoryList.value;
        final keys1 = <GlobalKey>[];
        for (var element in categoryList) {
          keys1.add(GlobalKey(debugLabel: 'section_${element.code}'));
        }

        return ListView.builder(
          controller: state.scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,

          itemBuilder: (BuildContext context, int index) {
            bool isSelect = current.code == categoryList[index].code;
            bool isPrevious = previous.code == categoryList[index].code;
            bool isNext = next.code == categoryList[index].code;

            return GestureDetector(
              onTap: (){

                logic.setCurrent(categoryList[index], index);

                //展示高度，即ListView展示高度
                double displayHeight = getScreenHeight(context) -
                    50 -
                    getStatusHeight(context) -
                    56 -
                    getBottomSpace(context);
                //item距离ListView顶部距离
                double item2Top = itemHeight * index;
                //item总高度
                double totalItemHeight = itemHeight * categoryList.length;

                //所需滚动距离
                double distance = item2Top < displayHeight / 2
                    ? 0.0
                    : item2Top - displayHeight / 2 + itemHeight;
                //如果滚动距离大于 ListView item总高度 减掉 展示高度，则只能滚动item总高度 减掉 展示高度
                if (distance > totalItemHeight - displayHeight) {
                  distance = totalItemHeight - displayHeight;
                }
                state.scrollController.animateTo(distance,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              child: Container(
                key: keys1[index],
                height: itemHeight,
                decoration: BoxDecoration(
                    color: isSelect ? Colors.white : CommonStyle.greyBgColor3,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(isPrevious ? 20 : 0),
                        topRight: Radius.circular(isNext ? 20 : 0))
                    ),
                child: Center(
                  child: Text(categoryList[index].name!, style: const TextStyle(fontSize: 12))
                      .paddingOnly(left: 15,right: 15),
                ),
              ).marginOnly(right: 8),
            );
          },
          itemCount: categoryList.length,
        );
      }),
    );
  }

  late double rWidth, bWidth;
  //gridview的item宽和高一样
  double thirdCateItemHeight = 0;
  Widget rightGroup(BuildContext context) {
    double itemHeight = 62.0;
    //右侧占屏幕三分之二
    rWidth = getScreenWidth(context) * 2 / 3;

    //gridview的item宽和高一样
    double thirdCateItemWidth = rWidth / 3;
    thirdCateItemHeight = thirdCateItemWidth;

    //右侧内容宽度
    bWidth = rWidth - 28;

    return Expanded(
      flex: 2,
      child: Obx(() {
        SecondGroupCategoryInfo secondGroupCategoryInfo = state.secondGroupCategoryInfo.value;
        String headUrl = secondGroupCategoryInfo.bannerUrl??"";
        List<SecondCateList> secondCateList = secondGroupCategoryInfo.secondCateList??[];
        SecondCateList? selectSecondCategoryInfo = state.selectSecondCategoryInfo.value;
        ScrollController gridViewController = state.gridViewController;
        ScrollController rightScrollController = state.rightScrollController;
        final keys = <GlobalKey>[];
        for (var element in secondCateList) {
          keys.add(GlobalKey(debugLabel: 'section_${element.categoryCode}'));
        }

        final secondKeys = <GlobalKey>[];
        for (var element in secondGroupCategoryInfo.secondCateList ?? []) {
          secondKeys.add(GlobalKey(debugLabel: 'second_${element.categoryCode}'));
        }


        void tabScrollToMiddle(int index) {
          double toLeft = 0;
          double total = 0;
          if (index != 0) {
            int newIndex = index - 1;
            for (int i = 0; i < secondCateList.length; i++) {
              RenderBox? box = secondKeys[i].currentContext?.findAncestorRenderObjectOfType<RenderBox>();
              if (box != null) {
                double w = box.size.width;
                total += w;
                if (i <= newIndex) {
                  toLeft += w;
                }
              }
            }
            toLeft = toLeft - bWidth / 2;
            if (toLeft < 0) toLeft = 0;
            if (toLeft > total - bWidth) toLeft = total - bWidth;
          }
          state.rightScrollController.animateTo(toLeft, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        }

        List<Widget> widgets = [];
        //二级分类上面的图片
        if (headUrl != "") {
          widgets.add(
            CachedNetworkImage(
              width: bWidth,
              height: 100,
              imageUrl: headUrl,
              placeholder: (context, url) => assetImage(Assets.imagesDefault, bWidth, 100),
              errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, bWidth, 100),
              fit: BoxFit.cover,
            ),
          );
        }

        widgets.add(
          Container(
            width: bWidth,
            height: 32,
            margin: const EdgeInsets.only(top: 10,bottom: 10),
            child: ListView.builder(
                shrinkWrap: true,
                controller: rightScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: secondCateList.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelect = selectSecondCategoryInfo.categoryCode == secondCateList[index].categoryCode;

                  return GestureDetector(
                    onTap: (){
                      // widget.onItemClick(categoryList[index], index);
                      if(!isSelect) {
                        logic.setCurrentselect(secondCateList[index], keys[index].currentContext, secondKeys[index].currentContext);

                        //滚动二级分类至中间
                        tabScrollToMiddle(index);
                      }
                    },
                    child: Container(
                      key: secondKeys[index],
                      height: 32.h,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      margin: EdgeInsets.only(right: index + 1 != secondCateList.length ? 8 : 0),
                      decoration: BoxDecoration(
                        color: isSelect ? CommonStyle.selectBgColor : CommonStyle.greyBgColor2,
                        borderRadius: const BorderRadius.all(Radius.circular(14)),
                        // borderRadius: BorderRadius.only(bottomRight: Radius.circular(isPrev ? 20 : 0), topRight: Radius.circular(isNext ? 20 : 0)),
                      ),
                      child: Text(secondCateList[index].categoryName!,
                          style: TextStyle(color: isSelect ? CommonStyle.themeColor : CommonStyle.primaryColor,
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  );
                }),
          ),
        );

        List<Widget> list = [];
        for (var section = 0; section < secondCateList.length; section++) {
          List<CateList> cateList = secondCateList[section].cateList ?? [];
          list.add(SliverToBoxAdapter(
            child: Container(
              key: keys[section],
              height: 30,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              child: Text(
                secondCateList[section].categoryName!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ));
          list.add(SliverGrid.builder(
            itemCount: cateList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 每行显示3个项
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              // 创建每一个网格项的内容
              return Column(
                children: [
                  CachedNetworkImage(
                    width: 58,
                    height: 58,
                    imageUrl: cateList[index].iconUrl!,
                    placeholder: (context, url) =>
                        assetImage(Assets.imagesDefault, 58, 58),
                    errorWidget: (context, url, error) =>
                        assetImage(Assets.imagesDefault, 58, 58),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height: 24,
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      cateList[index].categoryName!,
                      style: TextStyle(
                          fontSize: 12, color: CommonStyle.color777677),
                    ),
                  )
                ],
              );
            })
          );
        }

        widgets.add(Expanded(
            child: Padding(
                padding: EdgeInsets.zero,
                child: CustomScrollView(
                  controller: gridViewController,
                  // scrollBehavior: NoShadowScrollBehavior(),
                  slivers: list,
                ))));

        // widgets.add(ListView.builder(
        //   itemCount: secondCateList.length,
        //   itemBuilder: (context, index) {
        //     List<CateList> cateList = secondCateList[index].cateList ?? [];
        //     return Expanded(
        //       child: Column(
        //         children: <Widget>[
        //           ListTile(
        //             title: Text(secondCateList[index].categoryName ?? ""),
        //           ),
        //           GridView.builder(
        //             shrinkWrap: true,
        //             itemCount: cateList.length,
        //             physics: NeverScrollableScrollPhysics(),
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 3, // 每行显示3个项
        //               mainAxisSpacing: 0,
        //               crossAxisSpacing: 0,
        //               // childAspectRatio: 1.0, // 子项的宽度是高度的1倍
        //             ),
        //             itemBuilder: (context, index) {
        //               // 创建每一个网格项的内容
        //               return Column(
        //                 children: [
        //                   CachedNetworkImage(
        //                     width: 58,
        //                     height: 58,
        //                     imageUrl: cateList[index].iconUrl!,
        //                     placeholder: (context, url) =>
        //                         assetImage(Assets.imagesDefault, 58, 58),
        //                     errorWidget: (context, url, error) =>
        //                         assetImage(Assets.imagesDefault, 58, 58),
        //                     fit: BoxFit.fill,
        //                   ),
        //                   Container(
        //                     height: 24,
        //                     margin: const EdgeInsets.only(top: 4),
        //                     child: Text(
        //                       cateList[index].categoryName!,
        //                       style: TextStyle(
        //                           fontSize: 12, color: CommonStyle.color777677),
        //                     ),
        //                   )
        //                 ],
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ));

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: widgets,
          ),
        );
      }),
    );
  }

}
