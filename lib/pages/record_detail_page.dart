import 'package:flutter/material.dart';
import 'package:union_pay/beans/record_bean.dart';
import 'package:union_pay/pages/black_page.dart';
import 'package:union_pay/utils/utils.dart';
import 'package:union_pay/widgets/custom_keyboard_view.dart';

import 'update_record_page.dart';

class RecordDetailPage extends StatefulWidget {
  final TransferRecordBean record;

  const RecordDetailPage({Key? key, required this.record}) : super(key: key);

  @override
  createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  late TransferRecordBean detail;

  bool showCardNumber = false;

  @override
  void initState() {
    super.initState();
    detail = widget.record;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar: AppBar(
            elevation: 0,
            title: const Text('账单详情'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecordPage(detail: detail)))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          showCardNumber = false;
                          detail = value;
                        });
                      }
                    });
                  },
                  icon: Image.asset("assets/images/service.png", height: 25))
            ]),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                const SizedBox(height: 20),
                Text("${detail.type == '转账' ? '-' : '+'}￥${Utils.toStringAsFixed(detail.amount)}",
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                detail.isSuccess
                    ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Image.asset("assets/images/tsm_apply_result_success.png", height: 20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            color: Colors.grey,
                            height: 1,
                            width: 95),
                        Image.asset("assets/images/tsm_apply_result_success.png", height: 20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            color: Colors.grey,
                            height: 1,
                            width: 95),
                        Image.asset("assets/images/tsm_apply_result_success.png", height: 20)
                      ])
                    : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Image.asset("assets/images/tsm_apply_result_failure.png", height: 20),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            color: Colors.grey,
                            height: 1,
                            width: 95),
                        Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            child: Container(
                                height: 10,
                                width: 10,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey))),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            color: Colors.grey,
                            height: 1,
                            width: 95),
                        Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey)))
                      ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [Text("转出成功"), Text("处理中"), Text("转入成功")]),
                const SizedBox(height: 20),
                const Divider(height: 0),
                ...detail.isSuccess
                    ? []
                    : [
                        Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(children: [
                              Container(
                                  width: 90,
                                  alignment: Alignment.centerLeft,
                                  child: const Text("失败原因", style: TextStyle(fontSize: 15))),
                              Expanded(
                                  child: Text("${detail.reason}",
                                      style: const TextStyle(fontSize: 15, color: Colors.grey)))
                            ]))
                      ],
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(children: [
                      Container(
                          width: 90,
                          alignment: Alignment.centerLeft,
                          child: const Text("交易类型", style: TextStyle(fontSize: 15))),
                      Text("${detail.type}", style: const TextStyle(fontSize: 15, color: Colors.grey))
                    ])),
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(children: [
                      Container(
                          width: 90,
                          alignment: Alignment.centerLeft,
                          child: const Text("手续费", style: TextStyle(fontSize: 15))),
                      Text("${Utils.toStringAsFixed(detail.serviceCharge)}元",
                          style: const TextStyle(fontSize: 15, color: Colors.grey))
                    ])),
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(children: [
                      Container(
                          width: 90,
                          alignment: Alignment.centerLeft,
                          child: const Text("收款方", style: TextStyle(fontSize: 15))),
                      Text("${detail.toUserName}", style: const TextStyle(fontSize: 15, color: Colors.grey))
                    ])),
                ...detail.toIsCard
                    ? [
                        Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(children: [
                              Container(
                                  width: 90,
                                  alignment: Alignment.centerLeft,
                                  child: const Text("收款银行", style: TextStyle(fontSize: 15))),
                              Text("${detail.toBackName}", style: const TextStyle(fontSize: 15, color: Colors.grey))
                            ])),
                        Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(children: [
                              Container(
                                  width: 90,
                                  alignment: Alignment.centerLeft,
                                  child: const Text("收款卡号", style: TextStyle(fontSize: 15))),
                              Text(
                                  showCardNumber && !detail.isYourSelf
                                      ? detail.toBackCode!
                                      : Utils.hiddenCardCode(detail.toBackCode),
                                  style: const TextStyle(fontSize: 15, color: Colors.grey)),
                              ...detail.isYourSelf || showCardNumber
                                  ? []
                                  : [
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                          onTap: () async {
                                            // await showModalBottomSheet(
                                            //     context: context,
                                            //     builder: (_) {
                                            //       return const CustomKeyboardView();
                                            //     }).then((value) {
                                            //   if (value != null && value) {
                                            //     setState(() {
                                            //       showCardNumber = !showCardNumber;
                                            //     });
                                            //   }
                                            // });

                                            Navigator.push(
                                                    context, MaterialPageRoute(builder: (_) => const BlackPage()))
                                                .then((value) {
                                              setState(() {
                                                showCardNumber = !showCardNumber;
                                              });
                                            });
                                          },
                                          behavior: HitTestBehavior.opaque,
                                          child: Image.asset("assets/images/icon_balance_open.png", height: 18))
                                    ]
                            ]))
                      ]
                    : [
                        Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(children: [
                              Container(
                                  width: 90,
                                  alignment: Alignment.centerLeft,
                                  child: const Text("收款账号", style: TextStyle(fontSize: 15))),
                              Text(Utils.formatMobile(detail.toAccount),
                                  style: const TextStyle(fontSize: 15, color: Colors.grey))
                            ]))
                      ],
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(children: [
                      Container(
                          width: 90,
                          alignment: Alignment.centerLeft,
                          child: const Text("附言", style: TextStyle(fontSize: 15))),
                      Expanded(
                          child: Text(Utils.isEmpty(detail.remarks) ? "无" : detail.remarks,
                              style: const TextStyle(fontSize: 15, color: Colors.grey)))
                    ])),
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(children: [
                      Container(
                          width: 90,
                          alignment: Alignment.centerLeft,
                          child: const Text("付款方", style: TextStyle(fontSize: 15))),
                      Text("${detail.fromUserName}", style: const TextStyle(fontSize: 15, color: Colors.grey))
                    ])),
                ...detail.fromIsCard
                    ? [
                        Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(children: [
                              Container(
                                  width: 90,
                                  alignment: Alignment.centerLeft,
                                  child: const Text("付款银行", style: TextStyle(fontSize: 15))),
                              Text("${detail.fromBackName}", style: const TextStyle(fontSize: 15, color: Colors.grey))
                            ])),
                        Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(children: [
                              Container(
                                  width: 90,
                                  alignment: Alignment.centerLeft,
                                  child: const Text("付款卡号", style: TextStyle(fontSize: 15))),
                              Text(Utils.hiddenCardCode(detail.fromBackCode),
                                  style: const TextStyle(fontSize: 15, color: Colors.grey))
                            ]))
                      ]
                    : [
                        Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(children: [
                              Container(
                                  width: 90,
                                  alignment: Alignment.centerLeft,
                                  child: const Text("付款账户", style: TextStyle(fontSize: 15))),
                              Text(Utils.formatMobile(detail.fromAccount),
                                  style: const TextStyle(fontSize: 15, color: Colors.grey))
                            ]))
                      ],
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(children: [
                      Container(
                          width: 90,
                          alignment: Alignment.centerLeft,
                          child: const Text("创建时间", style: TextStyle(fontSize: 15))),
                      Text("${detail.createTime}", style: const TextStyle(fontSize: 15, color: Colors.grey))
                    ]))
              ])),
          Visibility(
              visible: !detail.isYourSelf,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: const Color(0xffEF1820), borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: const Text("通知收款人",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)))
              ]))
        ])));
  }
}
