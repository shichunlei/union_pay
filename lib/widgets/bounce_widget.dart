import 'package:flutter/material.dart';

class BounceWidget extends StatefulWidget {
  final Widget child;

  const BounceWidget({Key? key, required this.child}) : super(key: key);

  @override
  createState() => _BounceWidgetState();
}

class _BounceWidgetState extends State<BounceWidget> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        reverseDuration: const Duration(milliseconds: 100), duration: const Duration(milliseconds: 800), vsync: this);
    animation = Tween<double>(begin: .86, end: 1).animate(animController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.repeat(reverse: true);
        }
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(scale: animation.value, child: widget.child);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
