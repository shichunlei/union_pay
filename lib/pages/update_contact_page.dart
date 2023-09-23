import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:union_pay/beans/bank_bean.dart';
import 'package:union_pay/beans/contact_bean.dart';
import 'package:union_pay/utils/utils.dart';
import 'package:uuid/uuid.dart';

class UpdateContactPage extends StatefulWidget {
  final ContactRecordBean? contact;

  const UpdateContactPage({Key? key, this.contact}) : super(key: key);

  @override
  createState() => _UpdateContactPageState();
}

class _UpdateContactPageState extends State<UpdateContactPage> {
  late bool isUnionPayAccount;

  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController phoneController;

  String? backName;
  String? backIcon;
  late String cardType;

  bool isNew = false;

  late ContactRecordBean contact;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    codeController = TextEditingController();
    phoneController = TextEditingController();

    if (widget.contact != null) {
      isNew = widget.contact!.isNew;
      cardType = Utils.isEmpty(widget.contact!.type) ? widget.contact!.type! : "储蓄卡";
      isUnionPayAccount = widget.contact!.isUnionPayAccount;
      backName = widget.contact!.backName;
      backIcon = widget.contact!.icon;
      nameController.text = widget.contact!.userName!;
      codeController.text = widget.contact!.backCode != null ? widget.contact!.backCode! : "";
      phoneController.text = widget.contact!.account != null ? widget.contact!.account! : "";
    } else {
      cardType = "储蓄卡";
      isUnionPayAccount = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar: AppBar(title: Text(widget.contact != null ? '修改转账人信息' : "添加转账人"), actions: [
          TextButton(
              onPressed: () {
                if (Utils.isEmpty(nameController.text)) {
                  EasyLoading.showToast("请输入姓名");
                  return;
                }

                if (!isUnionPayAccount) {
                  if (Utils.isEmpty(backName)) {
                    EasyLoading.showToast("请选择银行");
                    return;
                  }

                  if (Utils.isEmpty(codeController.text)) {
                    EasyLoading.showToast("请输入银行卡号");
                    return;
                  }
                  if (codeController.text.trim().replaceAll(" ", "").length != 16 &&
                      codeController.text.trim().replaceAll(" ", "").length != 19) {
                    EasyLoading.showToast("银行卡号格式不对");
                    return;
                  }
                } else {
                  if (Utils.isEmpty(phoneController.text)) {
                    EasyLoading.showToast("请输入账号");
                    return;
                  }
                  if (phoneController.text.trim().replaceAll(" ", "").length != 11) {
                    EasyLoading.showToast("账号格式不正确");
                    return;
                  }
                }

                String id = "";
                if (widget.contact != null) {
                  id = widget.contact!.id!;
                } else {
                  var uuid = const Uuid();
                  id = uuid.v4();
                }

                contact = ContactRecordBean(
                    id: id,
                    account: phoneController.text.trim().replaceAll(" ", ""),
                    backCode: codeController.text.trim(),
                    backName: backName,
                    icon: backIcon,
                    isNew: isNew,
                    isUnionPayAccount: isUnionPayAccount,
                    type: cardType,
                    letter: nameController.text.trim().substring(nameController.text.trim().length - 1),
                    userName: nameController.text.trim());

                Navigator.pop(context, contact);
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
                          isUnionPayAccount = !value;
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
                        const Text("账户类型："),
                        const Spacer(),
                        Text(!isUnionPayAccount ? "银行卡号" : "云闪付账号", style: const TextStyle(fontSize: 13)),
                        const Icon(Icons.keyboard_arrow_right)
                      ]))),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    const Text("姓名"),
                    Expanded(
                        child: TextField(
                            controller: nameController,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                                isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                                border: InputBorder.none,
                                hintText: "请输入姓名",
                                hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.normal))))
                  ])),
              ...!isUnionPayAccount
                  ? [
                      GestureDetector(
                          onTap: () {
                            selectBack(context, backName, (BankBean value) {
                              setState(() {
                                backName = value.backName!;
                                backIcon = value.icon!;
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
                                Text(backName ?? "", style: const TextStyle(fontSize: 13)),
                                const Icon(Icons.keyboard_arrow_right)
                              ]))),
                      GestureDetector(
                          onTap: () {
                            showCardTypeDialog(context).then((value) {
                              if (value != null) {
                                setState(() {
                                  cardType = value;
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
                                const Text("银行类型："),
                                const Spacer(),
                                Text(cardType, style: const TextStyle(fontSize: 13)),
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
                                    controller: codeController,
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
                                    controller: phoneController,
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
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    const Text("是否为最近转账："),
                    const Spacer(),
                    CupertinoSwitch(
                        onChanged: (value) {
                          setState(() {
                            isNew = value;
                          });
                        },
                        value: isNew)
                  ])),
            ])));
  }

  /// 选择类型
  Future<dynamic> showTypeDialog(BuildContext context) async {
    return await showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(child: const Text("银行卡号"), onPressed: () => Navigator.of(context).pop(true)),
                CupertinoActionSheetAction(
                    child: const Text("云闪付账号"), onPressed: () => Navigator.of(context).pop(false))
              ],
              cancelButton:
                  CupertinoActionSheetAction(onPressed: () => Navigator.of(context).pop(), child: const Text("取消")));
        });
  }

  /// 选择类型
  Future<dynamic> showCardTypeDialog(BuildContext context) async {
    return await showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(child: const Text("储蓄卡"), onPressed: () => Navigator.of(context).pop("储蓄卡")),
                CupertinoActionSheetAction(child: const Text("信用卡"), onPressed: () => Navigator.of(context).pop("信用卡"))
              ],
              cancelButton:
                  CupertinoActionSheetAction(onPressed: () => Navigator.of(context).pop(), child: const Text("取消")));
        });
  }

  Future selectBack(BuildContext context, String? backName, Function(BankBean value) callback) async {
    int selectAgencyIndex = banks.indexWhere((element) => element.backName == backName);

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
                          callback(banks[index]);
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                            height: 42,
                            alignment: Alignment.center,
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Image.asset("assets/images/banks/${banks[index].icon}.png", height: 20),
                              const SizedBox(width: 20),
                              Text(banks[index].backName!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: index == selectAgencyIndex ? Theme.of(context).primaryColor : null)),
                            ])));
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(height: 0);
                  },
                  itemCount: banks.length));
        });
  }
}
