import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String image;
  final double? imageSize;
  final TextStyle? textStyle;
  final double? space;

  const ItemView(
      {Key? key, this.onTap, required this.title, required this.image, this.imageSize, this.textStyle, this.space})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap?.call,
            child: Column(children: [
              Image.asset(image, width: imageSize ?? 40, height: imageSize ?? 40),
              SizedBox(height: space ?? 5),
              Text(title, style: textStyle ?? const TextStyle(color: Color(0xff555555), fontSize: 13))
            ])));
  }
}
