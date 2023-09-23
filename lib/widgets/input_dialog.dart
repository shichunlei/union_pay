import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  final String? title;
  final String? content;
  final Function(String value)? onPressed;
  final String? hintText;

  const InputDialog({Key? key, this.title = "修改", this.content = "", this.onPressed, this.hintText = ""})
      : super(key: key);

  @override
  createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      })
      ..text = widget.content!;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: ShapeDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                    height: 70,
                    child: Center(
                        child: Text(widget.title!,
                            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                            textAlign: TextAlign.center))),
                Container(
                    margin: const EdgeInsets.only(left: 30, bottom: 20, right: 30),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffE5E5E5)),
                    child: TextField(
                        controller: controller,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: "${widget.hintText}",
                            hintStyle:
                                const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xffaaaaaa))),
                        style: const TextStyle(fontSize: 15, color: Color(0xff333333)))),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  TextButton(
                      child: const Text("取消", style: TextStyle(color: Color(0xff666666))),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  TextButton(
                      child: Text("确定", style: TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        widget.onPressed!(controller.text);
                      })
                ]),
                const SizedBox(height: 10)
              ]))
        ]));
  }
}
