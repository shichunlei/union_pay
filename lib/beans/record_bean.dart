class TransferMouthRecordBean {
  List<TransferRecordBean> children;
  String? date;

  TransferMouthRecordBean({this.children = const [], this.date});

  factory TransferMouthRecordBean.fromJson(Map<String, dynamic> json) {
    return TransferMouthRecordBean(
        children: json['children'] != null
            ? (json['children'] as List).map((i) => TransferRecordBean.fromJson(i)).toList()
            : [],
        date: json['date'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['children'] = children.map((v) => v.toJson()).toList();
    return data;
  }
}

class TransferRecordBean {
  String? id;
  num? amount;
  num serviceCharge;
  bool isSuccess;
  String? type;
  String? fromUserName;
  String? toUserName;
  String? fromBackName;
  String? toBackName;
  String? fromBackCode;
  String? toBackCode;
  String? fromAccount;
  String? toAccount;
  String? createTime;
  String remarks;
  bool isYourSelf;
  bool fromIsCard;
  bool toIsCard;
  String? reason;
  int? duration;

  TransferRecordBean(
      {this.id,
      this.amount = .0,
      this.serviceCharge = .0,
      this.isSuccess = true,
      this.isYourSelf = false,
      this.fromIsCard = true,
      this.toIsCard = true,
      this.type,
      this.fromUserName,
      this.toUserName,
      this.fromBackName,
      this.toBackName,
      this.fromBackCode,
      this.toBackCode,
      this.fromAccount,
      this.toAccount,
      this.createTime,
      this.remarks = "无",
      this.reason,
      this.duration});

  factory TransferRecordBean.fromJson(Map<String, dynamic> json) {
    return TransferRecordBean(
        id: json['id'],
        amount: json['amount'],
        serviceCharge: json['serviceCharge'] ?? 0.00,
        isSuccess: json['isSuccess'] ?? true,
        isYourSelf: json['isYourSelf'] ?? false,
        fromIsCard: json['fromIsCard'] ?? true,
        toIsCard: json['toIsCard'] ?? true,
        type: json['type'],
        reason: json['reason'],
        createTime: json['createTime'],
        fromUserName: json['fromUserName'],
        toUserName: json['toUserName'],
        fromBackName: json['fromBackName'],
        toBackName: json['toBackName'],
        fromBackCode: json['fromBackCode'],
        toBackCode: json['toBackCode'],
        fromAccount: json['fromAccount'],
        toAccount: json['toAccount'],
        remarks: json['remarks'] ?? "无",
        duration: DateTime.parse(json['createTime']).millisecondsSinceEpoch);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['serviceCharge'] = serviceCharge;
    data['createTime'] = createTime;
    data['isSuccess'] = isSuccess;
    data['isYourSelf'] = isYourSelf;
    data['toIsCard'] = toIsCard;
    data['fromIsCard'] = fromIsCard;
    data['type'] = type;
    data['duration'] = duration;
    data['reason'] = reason;
    data['fromUserName'] = fromUserName;
    data['toUserName'] = toUserName;
    data['fromBackName'] = fromBackName;
    data['toBackName'] = toBackName;
    data['fromBackCode'] = fromBackCode;
    data['toBackCode'] = toBackCode;
    data['fromAccount'] = fromAccount;
    data['toAccount'] = toAccount;
    data['remarks'] = remarks;
    return data;
  }
}
