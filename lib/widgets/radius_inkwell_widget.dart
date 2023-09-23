import 'package:flutter/material.dart';

/// 带圆角点击渐变的布局view
class RadiusInkWellWidget extends StatelessWidget {
  // 圆角半径
  final double radius;

  final BorderRadius? borderRadius;

  // 颜色
  final Color? color;
  final Widget child;
  final VoidCallback? onPressed;

  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  final BoxBorder? border;

  final GestureTapDownCallback? onTapDown;

  final GestureLongPressCallback? onLongPress;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry padding;

  final List<BoxShadow>? boxShadow;

  final bool showShadow;

  const RadiusInkWellWidget({
    Key? key,
    required this.child,
    this.radius = 0,
    this.borderRadius,
    this.color,
    required this.onPressed,
    this.onLongPress,
    this.border,
    this.onTapDown,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.colors = const [],
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.showShadow = false,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: showShadow
                ? boxShadow ??
                    [
                      BoxShadow(
                          blurRadius: 13,
                          spreadRadius: -14,
                          offset: const Offset(0, 14),
                          color: Theme.of(context).cardColor)
                    ]
                : []),
        margin: margin,
        child: Material(
            type: MaterialType.transparency,
            child: Ink(
                decoration: BoxDecoration(
                    color: colors.isNotEmpty
                        ? null
                        : color ?? (onPressed == null ? Theme.of(context).unselectedWidgetColor : Colors.transparent),
                    border: border,
                    borderRadius: borderRadius ?? BorderRadius.circular(radius),
                    gradient: colors.isNotEmpty ? LinearGradient(colors: colors, begin: begin, end: end) : null),
                child: InkWell(
                    onTapDown: onTapDown,
                    onLongPress: onLongPress,
                    borderRadius: borderRadius ?? BorderRadius.circular(radius),
                    onTap: onPressed,
                    child: Padding(padding: padding, child: child)))));
  }
}
