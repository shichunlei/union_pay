import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:union_pay/pages/black_page.dart';
import 'package:union_pay/pages/contact_record_page.dart';
import 'package:union_pay/pages/gesture_password_page.dart';
import 'package:union_pay/utils/sp_util.dart';
import 'package:union_pay/utils/utils.dart';
import 'package:union_pay/widgets/bounce_widget.dart';
import 'package:union_pay/widgets/item_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<String> images = [
    "assets/images/banner-1.png",
    "assets/images/banner-2.png",
    "assets/images/banner-3.png",
    "assets/images/banner-4.png",
    "assets/images/banner-5.png",
    "assets/images/banner-6.png",
  ];

  String selectCity = "北京市";

  List<String> cities = [];

  bool show = true;

  @override
  void initState() {
    super.initState();
    cities = [
      "北京市",
      "上海市",
      "广州市",
      "深圳市",
      "重庆市",
      "天津市",
      "杭州市",
      "武汉市",
      "长沙市",
      "郑州市",
      "太原市",
      "石家庄市",
      "济南市",
      "南京市",
      "哈尔滨市",
      "长春市",
      "沈阳市",
      "南宁市",
      "南昌市",
      "合肥市",
      "昆明市",
      "成都市",
      "西安市",
      "兰州市",
      "银川市",
      "拉萨市",
      "呼和浩特市",
      "乌鲁木齐市",
      "福州市",
      "海口市",
      "桂林市",
      "青岛市",
      "三亚市",
      "厦门市",
      "宁波市",
      "苏州市",
      "常州市",
      "无锡市",
      "大连市",
      "吉林市",
      "中国台湾",
      "中国香港",
      "中国澳门",
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        body: Stack(children: [
          AppBar(elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.light, backgroundColor: Colors.transparent),
          NotificationListener(
            onNotification: (ScrollNotification notification) {
              //1.监听事件的类型
              if (notification is ScrollStartNotification) {
                print("开始滚动...");
                show = false;
                setState(() {});
              } else if (notification is ScrollUpdateNotification) {
                print("正在滚动：${notification.metrics.pixels} - ${notification.metrics.maxScrollExtent}");
              } else if (notification is ScrollEndNotification) {
                print("滚动结束....");
                show = true;
                setState(() {});
              }
              return false;
            },
            child: SingleChildScrollView(
                child: Column(children: [
              // Container(
              //     color: Colors.white,
              //     child: Arc(
              //         edge: Edge.BOTTOM,
              //         arcType: ArcType.CONVEX,
              //         height: 30,
              //         child: Container(
              //             color: Colors.red,
              //             padding: EdgeInsets.only(top: Utils.navigationBarHeight + 20),
              //             child: Column(children: [
              //               Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //                 Column(children: [
              //                   Image.asset("assets/images/payments_receiving_white.png", width: 40, height: 40),
              //                   const SizedBox(height: 5),
              //                   const Text("收付款",
              //                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))
              //                 ]),
              //                 Column(children: [
              //                   Image.asset("assets/images/travel_white.png", width: 40, height: 40),
              //                   const SizedBox(height: 5),
              //                   const Text("出行",
              //                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))
              //                 ]),
              //                 Column(children: [
              //                   Image.asset("assets/images/scan_white_selection.png", width: 40, height: 40),
              //                   const SizedBox(height: 5),
              //                   const Text("扫一扫",
              //                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))
              //                 ]),
              //                 GestureDetector(
              //                     behavior: HitTestBehavior.opaque,
              //                     onTap: () {},
              //                     child: Column(children: [
              //                       Image.asset("assets/images/card_management_white_selection.png",
              //                           width: 40, height: 40),
              //                       const SizedBox(height: 5),
              //                       const Text("卡管理",
              //                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))
              //                     ]))
              //               ]),
              //               const SizedBox(height: 20),
              //               Container(height: 130)
              //             ])))),
              Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff3F38CC), Color(0xff625DF7), Color(0xffCAB7F3)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  padding: EdgeInsets.only(top: Utils.navigationBarHeight),
                  child: Image.asset("assets/images/top_bg.png", width: double.infinity, fit: BoxFit.fitWidth)),
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      const SizedBox(width: 5),
                      const ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "信用卡还款",
                          image: "assets/images/repayment.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      const ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "城市服务",
                          image: "assets/images/cities_service.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      const ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "充值缴费",
                          image: "assets/images/recharge.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      ItemView(
                          onTap: () {
                            bool show = SpUtil.getBool(SHOW_GESTURE_PASSWORD_KEY, defValue: true);
                            if (show) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const BlackPage(back: false)));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactRecordPage()));
                            }
                          },
                          space: 8,
                          imageSize: 30,
                          title: "转账",
                          image: "assets/images/transfer.png",
                          textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      const ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "新人礼包",
                          image: "assets/images/gift_bag.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(width: 5)
                    ]),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
                      SizedBox(width: 5),
                      ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "借款",
                          image: "assets/images/borrowing.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "活期+",
                          image: "assets/images/current.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "申请信用卡",
                          image: "assets/images/apply_credit_card.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "生活缴费",
                          image: "assets/images/living_contributions.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      ItemView(
                          space: 8,
                          imageSize: 30,
                          title: "更多",
                          image: "assets/images/more_life.png",
                          textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13)),
                      SizedBox(width: 5)
                    ])
                  ])),
              Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white, Color(0xfff6f6f6)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Theme.of(context).dividerColor),
                            gradient: const LinearGradient(
                                colors: [Colors.white, Color(0xfff6f6f6)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 5),
                        margin: const EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 10),
                        child: Row(children: [
                          Expanded(
                              child: Column(children: [
                            Row(children: [
                              Container(
                                  height: 5,
                                  width: 5,
                                  decoration:
                                      BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(right: 10)),
                              const Text("服务助手：信用卡还款提醒", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              const SizedBox(width: 15),
                              const Text("53分钟前", style: TextStyle(fontSize: 14, color: Colors.grey))
                            ]),
                            const SizedBox(height: 5),
                            Row(children: [
                              Container(
                                  height: 5,
                                  width: 5,
                                  decoration:
                                      BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(right: 10)),
                              const Text("服务助手：优惠通知", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              const SizedBox(width: 15),
                              const Text("昨天", style: TextStyle(fontSize: 14, color: Colors.grey))
                            ])
                          ])),
                          Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFF1B19), borderRadius: BorderRadius.circular(10))),
                          const Icon(Icons.keyboard_arrow_right)
                        ])),
                    AspectRatio(
                        aspectRatio: 4.5,
                        child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Image.asset(images[index], fit: BoxFit.fitWidth, width: double.infinity);
                            },
                            itemCount: images.length,
                            onTap: (int index) async {})),
                    // AspectRatio(
                    //     aspectRatio: 4.5,
                    //     child: Swiper(
                    //         autoplay: true,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return Container(
                    //               margin: const EdgeInsets.only(left: 15, right: 15),
                    //               child: ClipRRect(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   child: Image.network(images[index],
                    //                       fit: BoxFit.cover, height: double.infinity, width: double.infinity)));
                    //         },
                    //         itemCount: images.length,
                    //         pagination: const SwiperPagination(
                    //             builder: CustomSwiperPaginationBuilder(), alignment: Alignment.bottomCenter),
                    //         onTap: (int index) async {}))
                  ])),
              const SizedBox(height: 5),

              Image.asset("assets/images/home-1.png", width: double.infinity, fit: BoxFit.fitWidth),

              // Row(children: [
              //   const SizedBox(width: 15),
              //   Expanded(
              //       child: ClipRRect(
              //           borderRadius: BorderRadius.circular(15),
              //           child: Container(
              //               color: Colors.white,
              //               child: Column(children: [
              //                 const SizedBox(height: 10),
              //                 const Text("活期+",
              //                     style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700)),
              //                 const SizedBox(height: 3),
              //                 const Text("工资好收益",
              //                     style: TextStyle(color: Color(0xffCF4557), fontSize: 15, fontWeight: FontWeight.w600)),
              //                 Image.asset("assets/images/image-1.png")
              //               ])))),
              //   const SizedBox(width: 10),
              //   Expanded(
              //       child: ClipRRect(
              //           borderRadius: BorderRadius.circular(15),
              //           child: Container(
              //               color: Colors.white,
              //               child: Column(children: [
              //                 const SizedBox(height: 10),
              //                 const Text("优惠日",
              //                     style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700)),
              //                 const SizedBox(height: 3),
              //                 const Text("周周享优惠",
              //                     style: TextStyle(color: Color(0xff4C6A79), fontSize: 15, fontWeight: FontWeight.w600)),
              //                 Image.asset("assets/images/image-2.png")
              //               ])))),
              //   const SizedBox(width: 10),
              //   Expanded(
              //       child: ClipRRect(
              //           borderRadius: BorderRadius.circular(15),
              //           child: Container(
              //               color: Colors.white,
              //               child: Column(children: [
              //                 const SizedBox(height: 10),
              //                 const Text("甄荟选",
              //                     style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700)),
              //                 const SizedBox(height: 3),
              //                 const Text("甄选乐不停",
              //                     style: TextStyle(color: Color(0xffF95063), fontSize: 15, fontWeight: FontWeight.w600)),
              //                 Image.asset("assets/images/image-3.png")
              //               ])))),
              //   const SizedBox(width: 10),
              //   Expanded(
              //       child: ClipRRect(
              //           borderRadius: BorderRadius.circular(15),
              //           child: Container(
              //               color: Colors.white,
              //               child: Column(children: [
              //                 const SizedBox(height: 10),
              //                 const Text("商圈U宝藏",
              //                     style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700)),
              //                 const SizedBox(height: 3),
              //                 const Text("888元红包",
              //                     style: TextStyle(color: Color(0xffEFDC88), fontSize: 15, fontWeight: FontWeight.w600)),
              //                 Image.asset("assets/images/image-4.png")
              //               ])))),
              //   const SizedBox(width: 15)
              // ]),

              Image.asset("assets/images/home-2.png", width: double.infinity, fit: BoxFit.fitWidth),
              Image.asset("assets/images/home-3.png", width: double.infinity, fit: BoxFit.fitWidth),
              Image.asset("assets/images/home-4.png", width: double.infinity, fit: BoxFit.fitWidth),
              Image.asset("assets/images/home-5.png", width: double.infinity, fit: BoxFit.fitWidth),
              Image.asset("assets/images/home-6.png", width: double.infinity, fit: BoxFit.fitWidth),
              Image.asset("assets/images/home-7.png", width: double.infinity, fit: BoxFit.fitWidth),
              const SizedBox(height: 20),
            ])),
          ),
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff3F38CC), Color(0xff625DF7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              height: Utils.navigationBarHeight,
              padding: EdgeInsets.only(top: Utils.topSafeHeight),
              child: Row(children: [
                GestureDetector(
                    onTap: () {
                      selectCityDialog(context, selectCity, (value) {
                        setState(() {
                          selectCity = value;
                        });
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const SizedBox(width: 15),
                      Container(
                          constraints: const BoxConstraints(maxWidth: 70),
                          child: Text(selectCity,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 14))),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      const SizedBox(width: 10)
                    ])),
                Expanded(
                    child: Container(
                        height: kToolbarHeight - 18,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
                        child: Row(children: [
                          const SizedBox(width: 10),
                          Image.asset("assets/images/search_grey.png", width: 20, height: 20),
                          const SizedBox(width: 8),
                          const Expanded(child: Text("我是推客")),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.2), width: 2))),
                            child: Text("搜索",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor, fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                        ]))),
                const SizedBox(width: 15),
                Image.asset("assets/images/change_version.png", width: 25, height: 25),
                const SizedBox(width: 15),
                Image.asset("assets/images/add_white_new.png", width: 25, height: 25),
                const SizedBox(width: 15),
              ])),
          AnimatedPositioned(
              right: show ? 0 : -30,
              bottom: 200,
              duration: const Duration(milliseconds: 300),
              child: AnimatedOpacity(
                  opacity: show ? 1 : .2,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                      height: 67,
                      width: 75,
                      child: Stack(children: [
                        Positioned(
                            top: 0,
                            bottom: 18,
                            left: 5,
                            right: 0,
                            child: Image.asset("assets/images/image-removebg-preview.png", width: 70)),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: BounceWidget(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    alignment: Alignment.center,
                                    decoration:
                                        BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                                    child: const Text("签到",
                                        style: TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)))))
                      ]))))
        ]));
  }

  @override
  bool get wantKeepAlive => true;

  Future selectCityDialog(BuildContext context, String? city, Function(String value) callback) async {
    int selectAgencyIndex = cities.indexWhere((element) => element == city);

    await showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
              top: false,
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                        onTap: () {
                          callback(cities[index]);
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                            height: 42,
                            alignment: Alignment.center,
                            child: Text(cities[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: index == selectAgencyIndex ? Theme.of(context).primaryColor : null))));
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(height: 0);
                  },
                  itemCount: cities.length));
        });
  }
}
