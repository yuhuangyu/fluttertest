// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutterdemo/common/view/skeleton/placeholders.dart';
import 'package:shimmer/shimmer.dart';

Widget pageGoodsListSkeleton(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: const SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          LineTwoPlaceholder(),
          SizedBox(height: 16.0),
          LineTwoPlaceholder(),
        ],
      ),
    ),
  );
}
