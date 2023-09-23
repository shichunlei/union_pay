import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';

class CustomSwiperPaginationBuilder extends SwiperPlugin {
  /// Space between rects
  final double space;

  final Key? key;

  const CustomSwiperPaginationBuilder({this.key, this.space = 2});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(Container(
          key: Key("pagination_$i"),
          margin: EdgeInsets.all(space),
          child: active
              ? Image.asset("assets/images/white_selected.png", height: 5)
              : Image.asset("assets/images/white_unselected.png", height: 5)));
    }

    return Row(key: key, mainAxisSize: MainAxisSize.min, children: list);
  }
}
