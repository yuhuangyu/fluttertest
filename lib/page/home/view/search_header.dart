// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdemo/MyApp.dart';
import 'package:flutterdemo/RouteConfig.dart';
import 'package:flutterdemo/common/image/asset_image.dart';
import 'package:flutterdemo/common/style/common_style.dart';
import 'package:flutterdemo/common/view/persistentHeader/sliver_header_builder.dart';
import 'package:flutterdemo/generated/assets.dart';
import 'package:flutterdemo/util/screen_util.dart';
import 'package:get/get.dart';

Widget searchHeader(BuildContext context, RxDouble pageScrollY) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverHeaderDelegate(
      maxHeight: 88 + getStatusHeight(context),
      minHeight: 44 + getStatusHeight(context),
      child: Container(
        color: CommonStyle.placeholderColor,
        padding: EdgeInsets.only(top: getStatusHeight(context)),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
                top: 0,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteConfig.mymainpagepage);
                  },
                  child: assetImage(Assets.imagesIcPet, 36, 36),
                )),
            Positioned(
              top: 5,
              right: 18,
              child: assetImage(Assets.imagesIcScan, 32, 32),
            ),
            Obx(
              () => Positioned(
                top: calc2Top(pageScrollY.value),
                child: Container(
                  height: 34,
                  width: getScreenWidth(context) - calcWidth(pageScrollY.value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 34,
                        child: UnconstrainedBox(
                          child: assetImage(Assets.imagesIcSearch, 20, 20),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 34.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "homeSearchTip".tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: CommonStyle.placeholderColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 34,
                        child: UnconstrainedBox(
                          child: assetImage(Assets.imagesIcCamera, 20, 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


double calc2Top(double scrollY) {
  double result = 45;
  if (scrollY > 0 && scrollY <= 45) {
    result -= scrollY * 0.92;
  } else if (scrollY <= 0) {
    result = 45;
  } else {
    result = 45 * 0.08;
  }
  return result;
}

double calcWidth(double scrollY) {
  double result = 32;
  if (scrollY > 0 && scrollY <= 45) {
    result += scrollY * 2;
  } else if (scrollY <= 0) {
    result = 32;
  } else {
    result = 45 * 2 + 32;
  }
  return result;
}
