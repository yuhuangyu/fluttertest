// Flutter imports:
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterdemo/RouteConfig.dart';
import 'package:flutterdemo/common/image/asset_image.dart';
import 'package:flutterdemo/generated/assets.dart';
import 'package:flutterdemo/page/home/been/home_page_info.dart';
import 'package:flutterdemo/util/screen_util.dart';
import 'package:get/get.dart';


Widget advBanner(BuildContext context, Rx<HomePageInfo> homePageInfo) {
  return SliverToBoxAdapter(
    child: GestureDetector(
      onTap: () => Get.toNamed(
        RouteConfig.webview,
        arguments: {"url": "https://pro.m.jd.com/mall/active/2WrXYwmYpiy7EpWjDETSVyhXfLCb/index.html"},
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(0),
        child: Obx(
          () => CachedNetworkImage(
            height: 90,
            imageUrl: homePageInfo.value.adUrl ?? "",
            placeholder: (context, url) => assetImage(Assets.imagesDefault, getScreenWidth(context) - 24, 90),
            errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, getScreenWidth(context) - 24, 90),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}
