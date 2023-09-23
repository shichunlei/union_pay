import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:union_pay/utils/utils.dart';

class CustomKeyboardView extends StatefulWidget {
  const CustomKeyboardView({Key? key}) : super(key: key);

  @override
  createState() => _CustomKeyboardViewState();
}

class _CustomKeyboardViewState extends State<CustomKeyboardView> {
  List<String> password = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("请输入支付密码"), centerTitle: true, elevation: 0),
        body: Column(children: [
          const Divider(height: 1),
          Container(
              height: 60,
              margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).dividerColor, width: 1)),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    return Container(
                        width: (Utils.width - 31) / 6,
                        alignment: Alignment.center,
                        child: password.length > index
                            ? Image.asset("assets/images/ic_round_message_front.png", height: 10, width: 10)
                            : const SizedBox.shrink());
                  },
                  separatorBuilder: (_, index) {
                    return Container(width: .3, color: const Color(0xffaaaaaa));
                  },
                  itemCount: 6,
                  shrinkWrap: true)),
          Container(
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              child: TextButton(child: const Text("忘记密码"), onPressed: () {})),
          const Spacer(),
          Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: Utils.setBottomMargin(5)),
              color: const Color(0xffdddddd),
              child: Column(children: [
                Row(children: [
                  const SizedBox(width: 5),
                  buildNumberView("1"),
                  const SizedBox(width: 5),
                  buildNumberView("2"),
                  const SizedBox(width: 5),
                  buildNumberView("3"),
                  const SizedBox(width: 5)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  const SizedBox(width: 5),
                  buildNumberView("4"),
                  const SizedBox(width: 5),
                  buildNumberView("5"),
                  const SizedBox(width: 5),
                  buildNumberView("6"),
                  const SizedBox(width: 5)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  const SizedBox(width: 5),
                  buildNumberView("7"),
                  const SizedBox(width: 5),
                  buildNumberView("8"),
                  const SizedBox(width: 5),
                  buildNumberView("9"),
                  const SizedBox(width: 5)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  const SizedBox(width: 5),
                  Expanded(child: Container()),
                  const SizedBox(width: 5),
                  buildNumberView("0"),
                  const SizedBox(width: 5),
                  Expanded(
                      child: GestureDetector(
                          onTap: deleteNumber,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                              height: 40,
                              alignment: Alignment.center,
                              child: Image.asset("assets/images/icon_keyboard_delkey.png", height: 25)))),
                  const SizedBox(width: 5)
                ])
              ]))
        ]));
  }

  void selectNumber(String number) {
    password.add(number);
    setState(() {});
    if (password.length > 5) {
      EasyLoading.show(
          indicator: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: Image.asset("assets/images/login_loading.gif")));
      Future.delayed(const Duration(milliseconds: 1500), () {
        EasyLoading.dismiss();
        Navigator.pop(context, true);
      });
    }
  }

  void deleteNumber() {
    if (password.isEmpty) return;
    password.removeLast();
    setState(() {});
  }

  Widget buildNumberView(String number) {
    return Expanded(
        child: GestureDetector(
            onTap: password.length >= 6 ? null : () => selectNumber(number),
            behavior: HitTestBehavior.opaque,
            child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                height: 40,
                alignment: Alignment.center,
                child: Text(number,
                    style: const TextStyle(color: Color(0xff333333), fontWeight: FontWeight.bold, fontSize: 25)))));
  }
}
