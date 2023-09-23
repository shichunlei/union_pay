import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_pay/beans/record_bean.dart';
import 'package:union_pay/utils/sp_util.dart';
import 'package:union_pay/pages/update_record_page.dart';
import 'package:union_pay/utils/utils.dart';

import 'record_detail_page.dart';

class TransferRecordsPage extends StatefulWidget {
  const TransferRecordsPage({Key? key}) : super(key: key);

  @override
  createState() => _TransferRecordsPageState();
}

class _TransferRecordsPageState extends State<TransferRecordsPage> {
  List<TransferMouthRecordBean> months = [];

  @override
  void initState() {
    super.initState();
    getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar: AppBar(
            elevation: 0,
            title: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdateRecordPage())).then((value) {
                    getRecords();
                  });
                },
                child: const Text('转账记录')),
            centerTitle: true,
            backgroundColor: Colors.transparent),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            margin: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: .5))),
                            child: Text(
                                Utils.isSameYear("${months[index].date}")
                                    ? Utils.isSameMouth("${months[index].date}")
                                        ? '本月'
                                        : Utils.getMonth("${months[index].date}")
                                    : Utils.formatMonth("${months[index].date}"),
                                style:
                                    const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600))),
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (_, i) {
                              return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => RecordDetailPage(record: months[index].children[i])))
                                        .then((value) {
                                      getRecords();
                                    });
                                  },
                                  child: SizedBox(
                                      height: 60,
                                      child: Row(children: [
                                        const SizedBox(width: 20),
                                        const CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 15,
                                            backgroundImage: AssetImage("assets/images/ic_user_head.png")),
                                        const SizedBox(width: 15),
                                        Expanded(
                                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                                          Row(children: [
                                            Text(
                                                "${months[index].children[i].type}:"
                                                "${months[index].children[i].type == '转账' ? months[index].children[i].toUserName : months[index].children[i].fromUserName}",
                                                style: const TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                                            const Spacer(),
                                            Text(
                                                "${months[index].children[i].type == '转账' ? '-' : '+'}￥${Utils.toStringAsFixed(months[index].children[i].amount)}",
                                                style: const TextStyle(fontSize: 13))
                                          ]),
                                          const SizedBox(height: 5),
                                          Row(children: [
                                            Text(Utils.formatMonthDay(months[index].children[i].createTime),
                                                style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                            const Spacer(),
                                            Text(
                                                "${months[index].children[i].type}${months[index].children[i].isSuccess ? '成功' : '失败'}",
                                                style: TextStyle(
                                                    color: months[index].children[i].isSuccess
                                                        ? const Color(0xff537C37)
                                                        : const Color(0xffB53D51),
                                                    fontSize: 13))
                                          ])
                                        ])),
                                        const SizedBox(width: 15)
                                      ])));
                            },
                            itemCount: months[index].children.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true)
                      ]);
                    },
                    itemCount: months.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true))));
  }

  Future getRecords() async {
    String? result = SpUtil.getString(RECORDS_KEY);
    if (Utils.isEmpty(result)) {
      result = await rootBundle.loadString("assets/data/records.json", cache: true);
      SpUtil.setString(RECORDS_KEY, result);
    }

    List<TransferRecordBean> records =
        (json.decode(result!) as List).map((o) => TransferRecordBean.fromJson(o)).toList();

    /// 排序
    records.sort((a, b) => b.duration!.compareTo(a.duration!));
    months.clear();

    /// 按月重新组装数据
    for (var element in records) {
      if (months.isNotEmpty) {
        if (Utils.isEqualMonth(months.last.date, element.duration)) {
          /// 是同一月，则添加到同一月里
          months.last.children.add(element);
        } else {
          /// 不是同一月，则重新添加一个月份
          months.add(TransferMouthRecordBean(date: element.createTime, children: [element]));
        }
      } else {
        /// 列表为空
        months.add(TransferMouthRecordBean(date: element.createTime, children: [element]));
      }
    }

    setState(() {});
  }
}
