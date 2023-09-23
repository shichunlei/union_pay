import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_pay/beans/contact_bean.dart';
import 'package:union_pay/pages/transfer_records_page.dart';
import 'package:union_pay/pages/update_contact_page.dart';
import 'package:union_pay/utils/sp_util.dart';
import 'package:union_pay/utils/utils.dart';
import 'package:union_pay/widgets/input_dialog.dart';
import 'package:union_pay/widgets/item_view.dart';

class ContactRecordPage extends StatefulWidget {
  const ContactRecordPage({Key? key}) : super(key: key);

  @override
  createState() => _ContactRecordPageState();
}

class _ContactRecordPageState extends State<ContactRecordPage> {
  List<ContactRecordBean> records = [];

  bool showMore = false;

  bool showMore2 = false;

  bool showMoreBacks = false;

  bool showNotice = true;

  @override
  void initState() {
    super.initState();
    getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar:
            AppBar(elevation: 0, title: const Text('转账'), centerTitle: true, backgroundColor: Colors.white, actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdateContactPage())).then((value) {
                  if (value != null && mounted) {
                    if (value.isNew) {
                      for (var element in records) {
                        element.isNew = false;
                      }
                    }

                    setState(() {
                      records.add(value);
                    });

                    SpUtil.setString(CONTACTS_KEY, json.encode(records));
                  }
                });
              },
              icon: Image.asset("assets/images/more_black.png"))
        ]),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: Utils.bottomSafeHeight),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffF3F9FF)),
                  child: Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                colors: [Color(0xff2E81E3), Color(0xff1961CD)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                        child: Column(children: [
                          Visibility(
                              visible: showNotice,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white24),
                                  child: Row(children: [
                                    const SizedBox(width: 10),
                                    Image.asset("assets/images/notice_white.png", height: 20),
                                    const SizedBox(width: 20),
                                    const Expanded(
                                        child: Text("安全保障免费开通，保护您的资金交易安全", style: TextStyle(color: Colors.white))),
                                    GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          setState(() {
                                            showNotice = false;
                                          });
                                        },
                                        child: const Padding(
                                            padding: EdgeInsets.only(left: 8, right: 15),
                                            child: Icon(Icons.close, size: 12, color: Colors.white)))
                                  ]))),
                          const SizedBox(height: 15),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
                            ItemView(
                                space: 15,
                                title: "转到银行卡",
                                image: "assets/images/to_card.png",
                                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                            ItemView(
                                space: 15,
                                title: "转到云闪付用户",
                                image: "assets/images/to_unionpay.png",
                                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                            ItemView(
                                space: 15,
                                title: "收款",
                                image: "assets/images/make_collections.png",
                                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))
                          ]),
                          const SizedBox(height: 15)
                        ])),
                    const SizedBox(height: 15),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      const ItemView(title: "信用卡还款", image: "assets/images/repayment_black.png"),
                      const ItemView(title: "发红包", image: "assets/images/red_packet.png"),
                      const ItemView(title: "预约转账", image: "assets/images/schedule_transfer.png"),
                      ItemView(
                          title: "转账记录",
                          image: "assets/images/records.png",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return const TransferRecordsPage();
                            }));
                          })
                    ]),
                    ...showMore2
                        ? [
                            const SizedBox(height: 15),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
                              ItemView(title: "手机号转账", image: "assets/images/phone_number_transfer.png"),
                              ItemView(title: "余额查询", image: "assets/images/balance_inquiry.png"),
                              ItemView(title: "闲钱赚收益", image: "assets/images/income.png"),
                              ItemView(title: "添加银行卡", image: "assets/images/add_card.png")
                            ])
                          ]
                        : [],
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            showMore2 = !showMore2;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.only(top: 15, bottom: 10),
                            child: Icon(showMore2 ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)))
                  ])),
              Container(
                  margin: EdgeInsets.only(top: 15, bottom: Utils.setBottomMargin(15)),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  child: Column(children: [
                    Row(children: const [
                      Text("常用转账人", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.black)),
                      Spacer(),
                      Text("全部转账人", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black)),
                      Icon(Icons.keyboard_arrow_right)
                    ]),
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, index) {
                          return Column(children: [
                            GestureDetector(
                                onTap: () {
                                  if (records[index].children.isEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => UpdateContactPage(contact: records[index]))).then((value) {
                                      if (value != null && mounted) {
                                        if (value.isNew) {
                                          for (var element in records) {
                                            element.isNew = false;
                                          }
                                        }

                                        int index = records.indexWhere((element) => element.id == value.id);
                                        records[index] = value;
                                        setState(() {});

                                        SpUtil.setString(CONTACTS_KEY, json.encode(records));
                                      }
                                    });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return InputDialog(
                                              onPressed: (value) {
                                                Navigator.pop(context);
                                                records[index].userName = value;
                                                setState(() {});
                                                SpUtil.setString(CONTACTS_KEY, json.encode(records));
                                              },
                                              hintText: "请输入姓名",
                                              content: records[index].userName);
                                        });
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: SizedBox(
                                    height: 80,
                                    child: Row(children: [
                                      records[index].hasAvatar
                                          ? ClipOval(
                                              child: records[index].avatar == "default"
                                                  ? Image.asset("assets/images/ic_user_head.png", width: 40, height: 40)
                                                  : Image.network(records[index].avatar, width: 40, height: 40))
                                          : CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
                                              child: Text("${records[index].letter}",
                                                  style: TextStyle(color: Theme.of(context).primaryColor))),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                            Text("${records[index].userName}",
                                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                                            const SizedBox(height: 5),
                                            Row(children: [
                                              ...records[index].children.isNotEmpty
                                                  ? []
                                                  : [
                                                      records[index].isUnionPayAccount
                                                          ? Image.asset("assets/images/logo.png", width: 20, height: 20)
                                                          : Image.asset(
                                                              "assets/images/banks/${records[index].icon}.png",
                                                              width: 20,
                                                              height: 20),
                                                      const SizedBox(width: 8)
                                                    ],
                                              records[index].isUnionPayAccount
                                                  ? Text(Utils.formatMobile(records[index].account))
                                                  : records[index].children.isNotEmpty
                                                      ? Text("${records[index].children.length}张银行卡")
                                                      : Text(
                                                          "${records[index].backName} ${records[index].type} [${records[index].backCode!.trim().replaceAll(" ", "").substring(records[index].backCode!.trim().replaceAll(" ", "").length - 4)}]"),
                                              records[index].isNew
                                                  ? Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 7),
                                                      decoration: BoxDecoration(
                                                          color: const Color(0xff6D8FAA).withOpacity(.1),
                                                          borderRadius: BorderRadius.circular(3)),
                                                      margin: const EdgeInsets.only(left: 15),
                                                      child: const Text("最近转给我",
                                                          style: TextStyle(color: Color(0xff6D8FAA), fontSize: 10)))
                                                  : const SizedBox.shrink(),
                                              const Spacer(),
                                              records[index].children.isNotEmpty
                                                  ? GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        setState(() {
                                                          showMoreBacks = !showMoreBacks;
                                                        });
                                                      },
                                                      child: Icon(showMoreBacks
                                                          ? Icons.keyboard_arrow_up
                                                          : Icons.keyboard_arrow_down))
                                                  : const SizedBox.shrink()
                                            ])
                                          ]))
                                    ]))),
                            ListView.separated(
                                padding: const EdgeInsets.only(left: 50),
                                itemBuilder: (_, i) {
                                  return SizedBox(
                                      height: 50,
                                      child: Row(children: [
                                        Image.asset("assets/images/banks/${records[index].children[i].icon}.png",
                                            width: 20, height: 20),
                                        const SizedBox(width: 10),
                                        Text(
                                            "${records[index].children[i].backName}  ${records[index].children[i].type}  [${records[index].children[i].backCode!.trim().replaceAll(" ", "").substring(records[index].children[i].backCode!.trim().replaceAll(" ", "").length - 4)}]")
                                      ]));
                                },
                                separatorBuilder: (_, index) {
                                  return const Divider(height: 0);
                                },
                                itemCount: showMoreBacks ? records[index].children.length : 0,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true)
                          ]);
                        },
                        separatorBuilder: (_, index) {
                          return const Divider(height: 0);
                        },
                        itemCount: records.isNotEmpty
                            ? showMore
                                ? records.length
                                : 5
                            : 0,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            showMore = !showMore;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Icon(showMore ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)))
                  ]))
            ])));
  }

  Future getRecords() async {
    String? result = SpUtil.getString(CONTACTS_KEY);
    if (Utils.isEmpty(result)) {
      result = await rootBundle.loadString("assets/data/contact_records.json", cache: true);
      SpUtil.setString(CONTACTS_KEY, result);
    }

    records = (json.decode(result!) as List).map<ContactRecordBean>((o) => ContactRecordBean.fromJson(o)).toList();

    String? account = records.firstWhere((element) => element.children.isNotEmpty).account;

    SpUtil.setString(CURRENT_USER_KEY, account);

    setState(() {});
  }
}
