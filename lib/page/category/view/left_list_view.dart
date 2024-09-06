import 'package:flutter/material.dart';
import 'package:flutterdemo/common/style/common_style.dart';
import 'package:flutterdemo/page/category/been/category_list_entity.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';



class LeftListView extends StatefulWidget {
  final Function(CategoryInfo item, int index) onItemClick;
  List<CategoryInfo> categoryList;
  CategoryInfo current;

  LeftListView({Key? key, required this.categoryList, required this.current, required this.onItemClick}) : super(key: key);

  @override
  State<LeftListView> createState() => _LeftListViewState();
}

class _LeftListViewState extends State<LeftListView> {
  double itemHeight = 62.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Obx(() {
        return ListView.builder(
          // controller: state.scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            bool isSelect = widget.current.code == widget.categoryList[index].code;
            return GestureDetector(
              onTap: (){
                widget.onItemClick(widget.categoryList[index], index);
              },
              child: Container(
                height: itemHeight,
                decoration: BoxDecoration(
                  color: isSelect ? Colors.white : CommonStyle.greyBgColor3,
                  // borderRadius: BorderRadius.only(bottomRight: Radius.circular(isPrev ? 20 : 0), topRight: Radius.circular(isNext ? 20 : 0)),
                ),
                child: Center(
                  child: Text(widget.categoryList[index].name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            );
          },
          itemCount: widget.categoryList.length,
        );
      }),
    );
  }

}
