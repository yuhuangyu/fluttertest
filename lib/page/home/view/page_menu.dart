// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutterdemo/common/view/indicator/common_indicator.dart';
import 'package:flutterdemo/page/home/been/mine_menu_tab_info.dart';
import 'package:flutterdemo/page/home/view/menu_item.dart';

// Project imports:


class PageMenu extends StatefulWidget {
  /// 每行item数
  /// 默认 5
  final int? rowItemCount;

  /// 每页行数
  /// 默认 1
  final int? rowCount;

  ///数据列表
  final List<FunctionInfo> menuDataList;

  const PageMenu({
    super.key,
    required this.menuDataList,
    this.rowItemCount,
    this.rowCount,
  });

  @override
  State<PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  int indicatorIndex = 0;

  @override
  Widget build(BuildContext context) {
    int rowNum = widget.rowItemCount ?? 5;
    int rowCount = widget.rowCount ?? 1;
    //每页item数
    int pageItemCount = rowNum * rowCount;
    int menuLength = widget.menuDataList.length;
    int pageCount = (menuLength % pageItemCount) > 0 ? (menuLength ~/ pageItemCount) + 1 : (menuLength ~/ pageItemCount);

    return Container(
      height: rowCount * 86 + 10,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: PageView.builder(
              itemCount: pageCount,
              onPageChanged: (index) {
                setState(() {
                  indicatorIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                int gridViewItemCount = index < menuLength ~/ pageItemCount ? pageItemCount : menuLength % pageItemCount;

                return GridView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: gridViewItemCount,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowNum,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, position) {
                    return MenuItem(widget.menuDataList[index * pageItemCount + position]);
                  },
                );
              },
            ),
          ),
          Container(
            height: 10,
            width: double.infinity,
            alignment: Alignment.center,
            child: CommonIndicator(
              itemCount: pageCount,
              current: indicatorIndex,
            ),
          ),
        ],
      ),
    );
  }
}
