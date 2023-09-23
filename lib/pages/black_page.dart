import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_pay/pages/contact_record_page.dart';
import 'package:union_pay/utils/sp_util.dart';
import 'package:union_pay/utils/utils.dart';

class BlackPage extends StatefulWidget {
  final bool back;

  const BlackPage({Key? key, this.back = true}) : super(key: key);

  @override
  createState() => _BlackPageState();
}

class _BlackPageState extends State<BlackPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (widget.back) {
        Navigator.pop(context);
      } else {
        SpUtil.setBool(SHOW_GESTURE_PASSWORD_KEY, false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ContactRecordPage()));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false)
        ]));
  }
}
