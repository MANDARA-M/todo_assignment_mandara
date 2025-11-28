import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({this.isDetail = false, Key? key}) : super(key: key);

  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = isDetail ? size.height - 300 : 200.0;
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColor.themeColorWhite,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  const TitlePlaceholder({
    required this.width,
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12.0,
            color: AppColor.themeColorWhite,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: width,
            height: 12.0,
            color: AppColor.themeColorWhite,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  singleContainer,
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  const ContentPlaceholder({
    required this.lineType,
    Key? key,
  }) : super(key: key);
  final ContentLineType lineType;

  @override
  Widget build(BuildContext context) {
    if (lineType == ContentLineType.singleContainer) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColor.themeColorWhite,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: AppColor.themeColorWhite,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: AppColor.themeColorWhite,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: AppColor.themeColorWhite,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: AppColor.themeColorWhite,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
