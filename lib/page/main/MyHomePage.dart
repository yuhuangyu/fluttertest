import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../common/image/asset_image.dart';
import '../../common/style/common_style.dart';
import '../../common/view/lazy_load_indexed_stack.dart';
import '../../generated/assets.dart';
import '../../mixin/image_picker_mixin.dart';
import '../category/category_view.dart';
import '../home/home_view.dart';
import '../mine/mine_view.dart';

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with ImagePickerMixin{
  int _selectedIndex = 0;
  double iconSize = 30;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [HomePage(), CategoryPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    List<Map> barItems = [
      {"iconPath": Assets.imagesIcHome, "activeIconPath": Assets.imagesIcHomeActive, "label": "tabMainHome".tr},
      {"iconPath": Assets.imagesIcCategory, "activeIconPath": Assets.imagesIcCategoryActive, "label": "tabMainCategory".tr},
      // {"iconPath": Assets.imagesIcCart, "activeIconPath": Assets.imagesIcCartActive, "label": "tabMainCart".tr},
      {"iconPath": Assets.imagesIcMine, "activeIconPath": Assets.imagesIcMineActive, "label": "tabMainMine".tr},
    ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: [0, 1].contains(_selectedIndex) ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: LazyLoadIndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 24,
          enableFeedback: false,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black87,
          selectedItemColor: CommonStyle.themeColor,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: barItems
              .map((item) => BottomNavigationBarItem(
            icon: assetImage(item["iconPath"], iconSize, iconSize),
            activeIcon: assetImage(item["activeIconPath"], iconSize, iconSize),
            label: item["label"],
          ))
              .toList(),
        ),
      ),
    );
  }
}