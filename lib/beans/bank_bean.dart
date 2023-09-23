class BankBean {
  String? backCode;
  String? backName;
  String? icon;
  String? type;

  BankBean({this.backCode, this.backName, this.icon, this.type});

  factory BankBean.fromJson(Map<String, dynamic> json) {
    return BankBean(backCode: json['backCode'], backName: json['backName'], icon: json['icon'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backCode'] = backCode;
    data['backName'] = backName;
    data['icon'] = icon;
    data['type'] = type;
    return data;
  }
}
