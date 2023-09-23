import 'package:flutter/material.dart';
import 'package:union_pay/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:union_pay/widgets/radius_inkwell_widget.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return Container();
    return Scaffold(
        body: Stack(children: [
      SingleChildScrollView(
          child: Column(children: [
        Stack(children: [
          Image.asset("assets/images/mine/bg_mine_title_all.png", fit: BoxFit.fitWidth, width: double.infinity),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Row(children: [
                const SizedBox(width: 20),
                Image.asset("assets/images/avatar_new.png", height: 50),
                const SizedBox(width: 15),
                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("186****2581",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
                  RadiusInkWellWidget(
                      margin: const EdgeInsets.only(top: 6),
                      radius: 20,
                      color: Colors.white,
                      onPressed: () {},
                      child: Container(
                          height: 20,
                          width: 80,
                          alignment: Alignment.center,
                          child: const Text("个人中心>", style: TextStyle(color: Color(0xff333333)))))
                ])),
                RadiusInkWellWidget(
                    radius: 20,
                    color: Colors.white,
                    onPressed: () {},
                    child: Container(
                        height: 35,
                        width: 60,
                        alignment: Alignment.center,
                        child: Text("签到", style: TextStyle(color: Theme.of(context).primaryColor)))),
                const SizedBox(width: 20)
              ]))
        ]),
        Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
            child: Stack(children: [
              Image.asset("assets/images/mine/mine_not_vip_no_bottom.png", fit: BoxFit.fitWidth),
              Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(children: [
                    Expanded(
                        child: Column(children: const [
                      Text("专享特权", style: TextStyle(color: Colors.white, fontSize: 13)),
                      Text("贵宾厅", style: TextStyle(color: Colors.white, fontSize: 10)),
                    ])),
                    Container(height: 20, width: .5, color: Colors.white),
                    Expanded(
                        child: Column(children: const [
                      Text("兑换中心", style: TextStyle(color: Colors.white, fontSize: 13)),
                      Text("8折京东券", style: TextStyle(color: Colors.white, fontSize: 10)),
                    ])),
                    Container(height: 20, width: .5, color: Colors.white),
                    Expanded(
                        child: Column(children: const [
                      Text("云小圈", style: TextStyle(color: Colors.white, fontSize: 13)),
                      Text("互动赢积点", style: TextStyle(color: Colors.white, fontSize: 10)),
                    ])),
                    Container(height: 20, width: .5, color: Colors.white),
                    Expanded(
                        child: Column(children: const [
                      Text("我的积点", style: TextStyle(color: Colors.white, fontSize: 13)),
                      Text("0", style: TextStyle(color: Colors.white, fontSize: 10)),
                    ])),
                  ]))
            ])),
        Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xffD1C6BE), width: 2)),
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                child: Row(children: [
                  Image.asset("assets/images/mine/notice.png", height: 20),
                  Expanded(child: Container()),
                  const Icon(Icons.clear, color: Color(0xff923800))
                ])))
      ])),
      Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/mine/bg_mine_title.png"), fit: BoxFit.fill)),
          height: Utils.navigationBarHeight,
          child: AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/mine_customer_service.svg",
                  height: 25,
                  width: 25,
                )),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/mine_setting.svg",
                  height: 25,
                  width: 25,
                ))
          ]))
    ]));
  }

  @override
  bool get wantKeepAlive => true;
}
