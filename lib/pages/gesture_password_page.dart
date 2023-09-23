import 'package:flutter/material.dart';
import 'package:union_pay/pages/contact_record_page.dart';
import 'package:union_pay/utils/sp_util.dart';
import 'package:union_pay/utils/utils.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';

class GesturePasswordPage extends StatefulWidget {
  const GesturePasswordPage({Key? key}) : super(key: key);

  @override
  createState() => _GesturePasswordPageState();
}

class _GesturePasswordPageState extends State<GesturePasswordPage> {
  Color selectedColor = const Color(0xff0C6BFE);
  Color errorColor = const Color(0xff0C6BFE); // const Color(0xffFB2E4E)

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
        body: Stack(children: [
      Positioned(
          top: 0,
          right: 0,
          child: SafeArea(
              left: false,
              bottom: false,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: const Icon(Icons.clear, size: 30, color: Colors.black))))),
      Positioned(
          left: 40,
          right: 40,
          top: Utils.topSafeHeight + 30,
          child: Column(children: [
            Image.asset("assets/images/ic_user_head.png", width: 80, height: 80),
            const SizedBox(height: 15),
            Text(Utils.formatMobile(SpUtil.getString(CURRENT_USER_KEY)),
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
            const SizedBox(height: 20),
            const Text("请确保周围没有其他人可以看到您的手势密码", style: TextStyle(color: Color(0xff666666), fontSize: 15)),
            const SizedBox(height: 40),
            GesturePasswordWidget(
                lineColor: selectedColor,
                errorLineColor: errorColor,
                singleLineCount: 3,
                identifySize: 70,
                minLength: 4,
                errorItem: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100), color: errorColor.withAlpha(60)),
                    alignment: Alignment.center,
                    child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: errorColor))),
                normalItem: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    alignment: Alignment.center,
                    child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey[400]))),
                selectedItem: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100), color: selectedColor.withAlpha(60)),
                    alignment: Alignment.center,
                    child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: selectedColor))),
                answer: const [0, 1, 2, 4, 5],
                onComplete: (data) {
                  SpUtil.setBool(SHOW_GESTURE_PASSWORD_KEY, false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ContactRecordPage()));
                })
          ])),
      Positioned(
          right: 0,
          left: 0,
          bottom: Utils.bottomSafeHeight,
          child: Row(children: [
            Expanded(child: TextButton(onPressed: () {}, child: const Text("忘记手势密码"))),
            Container(width: 1, height: 15, color: Colors.blueAccent),
            Expanded(child: TextButton(onPressed: () {}, child: const Text("忘记手势密码"))),
            Container(width: 1, height: 15, color: Colors.blueAccent),
            Expanded(child: TextButton(onPressed: () {}, child: const Text("忘记手势密码")))
          ]))
    ]));
  }
}
