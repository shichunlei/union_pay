import 'bank_bean.dart';

class ContactRecordBean {
  String? id;
  String? account;
  String avatar;
  String? backCode;
  String? backName;
  List<BankBean> children;
  String? icon;
  bool isNew;
  bool isUnionPayAccount;
  String? letter;
  String? type;
  String? userName;
  bool hasAvatar;

  ContactRecordBean(
      {this.account,
      this.avatar = "default",
      this.backCode,
      this.backName,
      this.children = const [],
      this.icon,
      this.hasAvatar = false,
      this.isNew = false,
      this.isUnionPayAccount = false,
      this.letter,
      this.type,
      this.userName,
      this.id});

  factory ContactRecordBean.fromJson(Map<String, dynamic> json) {
    return ContactRecordBean(
        id: json['id'] ?? "",
        account: json['account'] ?? "",
        avatar: json['avatar'] ?? "default",
        backCode: json['backCode'] ?? "",
        backName: json['backName'] ?? "",
        children: json['children'] != null ? (json['children'] as List).map((i) => BankBean.fromJson(i)).toList() : [],
        icon: json['icon'] ?? "",
        isNew: json['isNew'] ?? false,
        hasAvatar: json['hasAvatar'] ?? false,
        isUnionPayAccount: json['isUnionPayAccount'] ?? false,
        letter: json['letter'] ?? "",
        type: json['type'] ?? "",
        userName: json['userName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['account'] = account;
    data['avatar'] = avatar;
    data['backCode'] = backCode;
    data['backName'] = backName;
    data['icon'] = icon;
    data['isNew'] = isNew;
    data['isUnionPayAccount'] = isUnionPayAccount;
    data['letter'] = letter;
    data['type'] = type;
    data['userName'] = userName;
    data['hasAvatar'] = hasAvatar;
    data['children'] = children.map((v) => v.toJson()).toList();
    return data;
  }
}
