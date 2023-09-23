import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:union_pay/beans/record_bean.dart';
import 'package:union_pay/utils/sp_util.dart';
import 'package:union_pay/utils/utils.dart';
import 'package:uuid/uuid.dart';

class UpdateRecordPage extends StatefulWidget {
  final TransferRecordBean? detail;

  const UpdateRecordPage({Key? key, this.detail}) : super(key: key);

  @override
  createState() => _UpdateRecordPageState();
}

class _UpdateRecordPageState extends State<UpdateRecordPage> {
  late TransferRecordBean detail;

  late TextEditingController priceController1, priceController2;
  late TextEditingController codeController1, codeController2;
  late TextEditingController nameController1, nameController2;
  late TextEditingController phoneController1, phoneController2;
  late TextEditingController remarkController;
  late TextEditingController reasonController;

  late bool isSuccess;
  late bool fromIsCard;
  late bool toIsCard;
  late bool isYourSelf;
  String? fromBackName;
  String? toBackName;
  late String createTime;
  late String type;

  @override
  void initState() {
    super.initState();

    priceController1 = TextEditingController();
    priceController2 = TextEditingController();
    codeController1 = TextEditingController();
    codeController2 = TextEditingController();
    nameController1 = TextEditingController();
    nameController2 = TextEditingController();
    phoneController1 = TextEditingController();
    phoneController2 = TextEditingController();
    remarkController = TextEditingController();
    reasonController = TextEditingController();

    if (widget.detail != null) {
      isSuccess = widget.detail!.isSuccess;
      fromIsCard = widget.detail!.fromIsCard;
      toIsCard = widget.detail!.toIsCard;
      fromBackName = widget.detail!.fromBackName!;
      toBackName = widget.detail!.toBackName!;
      createTime = widget.detail!.createTime!;
      type = widget.detail!.type!;
      isYourSelf = widget.detail!.isYourSelf;

      priceController1.text = "${widget.detail!.amount}";
      priceController2.text = "${widget.detail!.serviceCharge}";
      codeController1.text = "${widget.detail!.fromBackCode}";
      codeController2.text = "${widget.detail!.toBackCode}";
      nameController1.text = "${widget.detail!.fromUserName}";
      nameController2.text = "${widget.detail!.toUserName}";
      phoneController1.text = "${widget.detail!.fromAccount}";
      phoneController2.text = "${widget.detail!.toAccount}";
      remarkController.text = widget.detail!.remarks == "无" ? "" : widget.detail!.remarks;
      reasonController.text = widget.detail!.reason ?? "";
    } else {
      isSuccess = true;
      fromIsCard = true;
      toIsCard = true;
      createTime = DateTime.now().toIso8601String();
      type = "转账";
      isYourSelf = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar: AppBar(title: Text(widget.detail == null ? "添加转账记录" : '修改转账记录'), actions: [
          TextButton(
              onPressed: () {
                if (Utils.isEmpty(priceController1.text)) {
                  EasyLoading.showToast("请输入$type金额");
                  return;
                }

                if (!isSuccess && Utils.isEmpty(reasonController.text)) {
                  EasyLoading.showToast("请输入$type失败原因");
                  return;
                }

                if (Utils.isEmpty(nameController1.text)) {
                  EasyLoading.showToast("请输入${isYourSelf ? '' : '付款人'}姓名");
                  return;
                }

                if (fromIsCard) {
                  if (Utils.isEmpty(fromBackName)) {
                    EasyLoading.showToast("请选择付款银行");
                    return;
                  }

                  if (Utils.isEmpty(codeController1.text)) {
                    EasyLoading.showToast("请输入付款方银行卡号");
                    return;
                  }
                  if (codeController1.text.trim().replaceAll(" ", "").length != 16 &&
                      codeController1.text.trim().replaceAll(" ", "").length != 19) {
                    EasyLoading.showToast("付款方银行卡号格式不对");
                    return;
                  }
                } else {
                  if (Utils.isEmpty(phoneController1.text)) {
                    EasyLoading.showToast("请输入付款方账号");
                    return;
                  }
                  if (phoneController1.text.trim().replaceAll(" ", "").length != 11) {
                    EasyLoading.showToast("付款方账号格式不正确");
                    return;
                  }
                }

                if (!isYourSelf && Utils.isEmpty(nameController2.text)) {
                  EasyLoading.showToast("请输入收款方姓名");
                  return;
                }

                if (toIsCard) {
                  if (Utils.isEmpty(toBackName)) {
                    EasyLoading.showToast("请选择收款银行");
                    return;
                  }

                  if (Utils.isEmpty(codeController2.text)) {
                    EasyLoading.showToast("请输入收款方银行卡号");
                    return;
                  }
                  if (codeController2.text.trim().replaceAll(" ", "").length != 16 &&
                      codeController2.text.trim().replaceAll(" ", "").length != 19) {
                    EasyLoading.showToast("收款方银行卡号格式不正确");
                    return;
                  }
                } else {
                  if (Utils.isEmpty(phoneController2.text)) {
                    EasyLoading.showToast("请输入收款方账号");
                    return;
                  }
                  if (phoneController2.text.trim().replaceAll(" ", "").length != 11) {
                    EasyLoading.showToast("收款方账号格式不正确");
                    return;
                  }
                }

                String? id;
                if (widget.detail != null) {
                  id = widget.detail!.id;
                } else {
                  var uuid = const Uuid();
                  id = uuid.v4();
                }

                detail = TransferRecordBean(
                    id: id,
                    type: type,
                    createTime: createTime.replaceAll("T", " ").replaceAll(".000", ""),
                    duration: DateTime.parse(createTime).millisecondsSinceEpoch,
                    amount: num.tryParse(priceController1.text),
                    serviceCharge: Utils.isEmpty(priceController2.text) ? .0 : num.tryParse(priceController2.text)!,
                    isSuccess: isSuccess,
                    fromBackName: fromBackName,
                    toBackName: toBackName,
                    fromIsCard: fromIsCard,
                    toIsCard: toIsCard,
                    isYourSelf: isYourSelf,
                    fromUserName: nameController1.text.trim(),
                    toUserName: isYourSelf ? nameController1.text.trim() : nameController2.text.trim(),
                    fromBackCode: toIsCard ? codeController1.text : "",
                    toBackCode: toIsCard ? codeController2.text : "",
                    fromAccount: toIsCard ? "" : phoneController1.text,
                    toAccount: toIsCard ? "" : phoneController2.text,
                    remarks: remarkController.text.trim(),
                    reason: reasonController.text.trim());

                String? result = SpUtil.getString(RECORDS_KEY);
                if (result != null) {
                  List<TransferRecordBean> records =
                      (json.decode(result) as List).map((o) => TransferRecordBean.fromJson(o)).toList();
                  int index = records.indexWhere((element) => element.id == detail.id);

                  if (index == -1) {
                    records.add(detail);
                  } else {
                    records[index] = detail;
                  }
                  SpUtil.setString(RECORDS_KEY, json.encode(records));
                }

                Navigator.pop(context, detail);
              },
              child: const Text("确定 "))
        ]),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              GestureDetector(
                  onTap: () {
                    showTypeDialog(context).then((value) {
                      if (value != null) {
                        setState(() {
                          type = value;
                        });
                      }
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        const Text("交易类型："),
                        const Spacer(),
                        Text(type, style: const TextStyle(fontSize: 13)),
                        const Icon(Icons.keyboard_arrow_right)
                      ]))),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Text("$type金额："),
                    Expanded(
                        child: TextField(
                            controller: priceController1,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.end,
                            inputFormatters: [Utils.priceInputFormatter()],
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                border: InputBorder.none,
                                hintText: "请输入$type金额",
                                hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                  ])),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Text("$type手续费："),
                    Expanded(
                        child: TextField(
                            controller: priceController2,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.end,
                            inputFormatters: [Utils.priceInputFormatter()],
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                border: InputBorder.none,
                                hintText: "请输入$type手续费金额",
                                hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                  ])),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Text("$type是否成功："),
                    const Spacer(),
                    CupertinoSwitch(
                        onChanged: (value) {
                          setState(() {
                            isSuccess = value;
                          });
                        },
                        value: isSuccess)
                  ])),
              ...isSuccess
                  ? []
                  : [
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text("失败原因："),
                            Expanded(
                                child: TextField(
                                    controller: reasonController,
                                    minLines: 1,
                                    maxLines: 3,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                        isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                        border: InputBorder.none,
                                        hintText: "请输入失败原因😁",
                                        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                          ]))
                    ],
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    const Text("付款方和收款方是否均为自己："),
                    const Spacer(),
                    CupertinoSwitch(
                        onChanged: (value) {
                          setState(() {
                            isYourSelf = value;
                          });
                        },
                        value: isYourSelf)
                  ])),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Text(isYourSelf ? "姓名" : "付款人："),
                    Expanded(
                        child: TextField(
                            controller: nameController1,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                border: InputBorder.none,
                                hintText: "请输入${isYourSelf ? '' : '付款人'}姓名",
                                hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                  ])),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    const Text("是否为银行卡付款："),
                    const Spacer(),
                    CupertinoSwitch(
                        onChanged: (value) {
                          setState(() {
                            fromIsCard = value;
                          });
                        },
                        value: fromIsCard)
                  ])),
              ...fromIsCard
                  ? [
                      GestureDetector(
                          onTap: () {
                            selectBack(context, fromBackName, (value) {
                              setState(() {
                                fromBackName = value;
                              });
                            });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(children: [
                                const Text("付款银行："),
                                const Spacer(),
                                Text(fromBackName ?? "", style: const TextStyle(fontSize: 13)),
                                const Icon(Icons.keyboard_arrow_right)
                              ]))),
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(children: [
                            const Text("付款银行卡号："),
                            Expanded(
                                child: TextField(
                                    controller: codeController1,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.end,
                                    inputFormatters: [
                                      //只允许输入数字
                                      FilteringTextInputFormatter.digitsOnly,
                                      //只允许输入 19位以内
                                      LengthLimitingTextInputFormatter(19), Utils.cardNumberInputFormatter()
                                    ],
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                        isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                        border: InputBorder.none,
                                        hintText: "请输入银行卡号",
                                        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                          ]))
                    ]
                  : [
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(children: [
                            const Text("付款账号："),
                            Expanded(
                                child: TextField(
                                    controller: phoneController1,
                                    maxLines: 1,
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.end,
                                    inputFormatters: [Utils.phoneInputFormatter()],
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                        isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                        border: InputBorder.none,
                                        hintText: "请输入付款账号",
                                        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                          ]))
                    ],
              ...isYourSelf
                  ? []
                  : [
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(children: [
                            const Text("收款方："),
                            Expanded(
                                child: TextField(
                                    controller: nameController2,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                        isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                        border: InputBorder.none,
                                        hintText: "请输入收款方姓名",
                                        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                          ]))
                    ],
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    const Text("是否为银行卡收款："),
                    const Spacer(),
                    CupertinoSwitch(
                        onChanged: (value) {
                          setState(() {
                            toIsCard = value;
                          });
                        },
                        value: toIsCard)
                  ])),
              ...toIsCard
                  ? [
                      GestureDetector(
                          onTap: () {
                            selectBack(context, toBackName, (value) {
                              setState(() {
                                toBackName = value;
                              });
                            });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(children: [
                                const Text("收款银行："),
                                const Spacer(),
                                Text(toBackName ?? "", style: const TextStyle(fontSize: 13)),
                                const Icon(Icons.keyboard_arrow_right)
                              ]))),
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(children: [
                            const Text("收款银行卡号："),
                            Expanded(
                                child: TextField(
                                    controller: codeController2,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.end,
                                    inputFormatters: [
                                      // 只允许输入数字
                                      FilteringTextInputFormatter.digitsOnly,
                                      // 只允许输入 19位以内
                                      LengthLimitingTextInputFormatter(19), Utils.cardNumberInputFormatter()
                                    ],
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                        isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                        border: InputBorder.none,
                                        hintText: "请输入银行卡号",
                                        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                          ]))
                    ]
                  : [
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(children: [
                            const Text("收款账号："),
                            Expanded(
                                child: TextField(
                                    controller: phoneController2,
                                    maxLines: 1,
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.end,
                                    inputFormatters: [Utils.phoneInputFormatter()],
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                    decoration: const InputDecoration(
                                        isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                        border: InputBorder.none,
                                        hintText: "请输入收款账号",
                                        hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                          ]))
                    ],
              GestureDetector(
                  onTap: () {
                    DatePickerBdaya.showDateTimePicker(context,
                            locale: LocaleType.zh, currentTime: DateTime.parse(createTime), maxTime: DateTime.now())
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          createTime = value.toIso8601String();
                        });
                      }
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        const Text("创建时间："),
                        const Spacer(),
                        Text(createTime.replaceAll("T", " ").replaceAll(".000", ""),
                            style: const TextStyle(fontSize: 13)),
                        const Icon(Icons.keyboard_arrow_right)
                      ]))),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text("附言："),
                    Expanded(
                        child: TextField(
                            controller: remarkController,
                            minLines: 1,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                                isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                border: InputBorder.none,
                                hintText: "请输入附言😁",
                                hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                  ]))
            ])));
  }

  /// 选择类型
  Future<dynamic> showTypeDialog(BuildContext context) async {
    return await showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(child: const Text("转账"), onPressed: () => Navigator.of(context).pop("转账")),
                CupertinoActionSheetAction(child: const Text("收款"), onPressed: () => Navigator.of(context).pop("收款"))
              ],
              cancelButton:
                  CupertinoActionSheetAction(onPressed: () => Navigator.of(context).pop(), child: const Text("取消")));
        });
  }

  Future selectBack(BuildContext context, String? backName, Function(String value) callback) async {
    int selectAgencyIndex = banksList.indexWhere((element) => element == backName);

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
                          callback(banksList[index]);
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 42,
                            alignment: Alignment.center,
                            child: Text(banksList[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: index == selectAgencyIndex ? Theme.of(context).primaryColor : null))));
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(height: 0);
                  },
                  itemCount: banksList.length));
        });
  }
}
