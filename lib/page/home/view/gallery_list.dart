// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutterdemo/common/image/asset_image.dart';
import 'package:flutterdemo/common/style/common_style.dart';
import 'package:flutterdemo/generated/assets.dart';
import 'package:flutterdemo/page/home/been/home_page_info.dart';
import 'package:flutterdemo/util/screen_util.dart';
import 'package:get/get.dart';


Widget galleryList(BuildContext context, Rx<HomePageInfo> homePageInfo) {
  double carouselWidth = getScreenWidth(context) - 24;
  double carouselHeight = 160;

  return SliverToBoxAdapter(
    child: Container(
      color: CommonStyle.themeColor,
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: Obx(() {
          var bannerList = homePageInfo.value.bannerList ?? [];
          return FlutterCarousel(
            options: CarouselOptions(
              height: carouselHeight,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 8),
              disableCenter: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              slideIndicator: CircularWaveSlideIndicator(
                  slideIndicatorOptions: SlideIndicatorOptions(
                itemSpacing: 12,
                indicatorRadius: 3.6,
                indicatorBorderWidth: 0,
                currentIndicatorColor: CommonStyle.themeColor,
                indicatorBackgroundColor: Colors.grey,
              )),
            ),
            items: bannerList.map(
              (item) {
                return GestureDetector(
                  // onTap: () => Get.toNamed(RoutesEnum.detailPage.path),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: CachedNetworkImage(
                        width: carouselWidth,
                        height: carouselHeight,
                        imageUrl: item.imgUrl!,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => assetImage(Assets.imagesDefault, carouselWidth, carouselHeight),
                        errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, carouselWidth, carouselHeight),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        }),
      ),
    ),
  );
}
