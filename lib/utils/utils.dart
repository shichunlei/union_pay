import 'dart:ui' as ui show window;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_pay/beans/bank_bean.dart';

class Utils {
  /// Get [MediaQueryData] from [ui.window]
  /// 通过 [ui.window] 获取 [MediaQueryData]
  static MediaQueryData get mediaQuery => MediaQueryData.fromWindow(ui.window);

  /// The number of device pixels for each logical pixel.
  /// 设备每个逻辑像素对应的dp比例
  static double get scale => mediaQuery.devicePixelRatio;

  /// 屏幕宽
  ///
  static double get width => mediaQuery.size.width;

  /// 屏幕高
  ///
  static double get height => mediaQuery.size.height;

  /// 标题栏高度（包括状态栏）
  ///
  static double get navigationBarHeight => mediaQuery.padding.top + kToolbarHeight;

  /// 状态栏高度
  ///
  static double get topSafeHeight => mediaQuery.padding.top;

  /// 底部状态栏高度
  ///
  static double get bottomSafeHeight => mediaQuery.padding.bottom;

  /// Method to update status bar's style.
  /// 更新状态栏样式的方法
  static void updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 隐藏键盘
  ///
  /// [context] 上下文
  ///
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 设置底部间距
  static double setBottomMargin(double margin) => bottomSafeHeight == 0 ? margin : bottomSafeHeight;

  static void lockScreenPortrait() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  static void unlockScreenPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }

  static String toStringAsFixed(num? number, {int fractionDigits = 2}) {
    number ??= 0;
    return number.toStringAsFixed(fractionDigits);
  }

  /// 隐藏银行卡号码
  ///
  /// [cardCode] 银行卡号码 6214 0000 2203 0023 091
  ///
  /// return 6214 **** 3091
  ///
  static String hiddenCardCode(String? cardCode) {
    if (isEmpty(cardCode)) {
      return "非法卡号";
    } else {
      String code = cardCode!.trim().replaceAll(" ", "");
      if (code.length == 16 || code.length == 19) {
        return "${code.substring(0, 4)} **** ${code.substring(code.length - 4, code.length)}";
      } else {
        return "非法卡号";
      }
    }
  }

  /// 手机号码中间4位替换成*
  ///
  /// [mobile] 手机号码 18822033302
  ///
  /// return 188****3302
  ///
  static String formatMobile(String? mobile) {
    if (isEmpty(mobile) || mobile!.replaceAll(" ", "").length != 11) return (mobile ?? "");
    Pattern regex = RegExp(r'(1\w{2})(\w{4})(\w{4})');
    return mobile.replaceAllMapped(regex, (match) => '${match[1]}****${match[3]}');
  }

  /// isEmpty
  static bool isEmpty(String? text) {
    return null == text || text.trim().isEmpty;
  }

  /// isNotEmpty
  static bool isNotEmpty(String? text) {
    return !isEmpty(text);
  }

  static bool isSameYear(String? date) {
    if (isEmpty(date)) return false;
    return DateTime.parse(date!).year == DateTime.now().year;
  }

  static bool isSameMouth(String? date) {
    if (isEmpty(date)) return false;
    return DateTime.parse(date!).year == DateTime.now().year && DateTime.parse(date).month == DateTime.now().month;
  }

  static String getMonth(String? date) {
    if (isEmpty(date)) return "";
    return "${DateTime.parse(date!).month}月";
  }

  static String formatMonth(String? date) {
    if (isEmpty(date)) return "";
    return "${DateTime.parse(date!).year}年${DateTime.parse(date).month}月";
  }

  static String formatMonthDay(String? date) {
    if (isEmpty(date)) return "";
    return "${'${DateTime.parse(date!).month}'.padLeft(2, "0")}月${'${DateTime.parse(date).day}'.padLeft(2, "0")}日";
  }

  static bool isEqualMonth(String? firstTime, int? secondTime) {
    if (firstTime == null || secondTime == null) return false;
    DateTime first = DateTime.parse(firstTime);
    DateTime second = DateTime.fromMillisecondsSinceEpoch(secondTime);

    return first.year == second.year && first.month == second.month;
  }

  static TextInputFormatter phoneInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text;
      //获取光标左边的文本
      final positionStr = (text.substring(0, newValue.selection.baseOffset)).replaceAll(RegExp(r"\s+\b|\b\s"), "");
      //计算格式化后的光标位置
      int length = positionStr.length;
      var position = 0;
      if (length <= 3) {
        position = length;
      } else if (length <= 7) {
        // 因为前面的字符串里面加了一个空格
        position = length + 1;
      } else if (length <= 11) {
        // 因为前面的字符串里面加了两个空格
        position = length + 2;
      } else {
        // 号码本身为 11 位数字，因多了两个空格，故为 13
        position = 13;
      }

      //这里格式化整个输入文本
      text = text.replaceAll(RegExp(r"\s+\b|\b\s"), "");
      var string = "";
      for (int i = 0; i < text.length; i++) {
        // 这里第 4 位，与第 8 位，我们用空格填充
        if (i == 3 || i == 7) {
          if (text[i] != " ") {
            string = "$string ";
          }
        }
        string += text[i];
      }

      return TextEditingValue(
          text: string.length > 13 ? string.substring(0, 13) : string,
          selection: TextSelection.fromPosition(TextPosition(offset: position, affinity: TextAffinity.upstream)));
    });
  }

  static TextInputFormatter cardNumberInputFormatter() {
    return TextInputFormatter.withFunction((TextEditingValue oldValue, TextEditingValue newValue) {
      //光标的位置 从0开始
      if (newValue.selection.baseOffset == 0) return newValue;

      // 获取输入的文本
      String inputData = newValue.text;
      //创建字符缓存体
      StringBuffer stringBuffer = StringBuffer();

      for (int i = 0; i < inputData.length; i++) {
        //获取每一个字条 inputData[i]
        stringBuffer.write(inputData[i]);
        //index 当前字条的位置
        int index = i + 1;
        //每四个字条中间添加一个空格 最后一位不在考虑范围里
        if (index % 4 == 0 && inputData.length != index) stringBuffer.write(" ");
      }
      return TextEditingValue(
          //当前的文本
          text: stringBuffer.toString(),
          //光标的位置
          selection: TextSelection.collapsed(
              //设置光标的位置在 文本最后
              offset: stringBuffer.toString().length));
    });
  }

  static TextInputFormatter priceInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      // 光标的位置 从0开始
      if (newValue.selection.baseOffset == 0) return newValue;

      // 获取输入的文本
      String inputData = newValue.text;

      // 不能输入除数字和小数点的其他字符
      RegExp regExp = RegExp("^[\\.\\d]+\$");
      if (!regExp.hasMatch(newValue.text)) inputData = oldValue.text;

      // 第一位不能是小数点
      if (newValue.text == ".") inputData = "";

      // 已经有一位小数点后不能在输入小数点
      if (oldValue.text.contains(".") &&
          oldValue.text.length < newValue.text.length &&
          newValue.text.substring(oldValue.text.length, newValue.text.length) == ".") {
        inputData = oldValue.text;
      }

      // 小数点后最多两位小数
      if (oldValue.text.contains(".") && newValue.text.contains(".") && newValue.text.split(".")[1].length > 2) {
        inputData = oldValue.text;
      }

      return TextEditingValue(
          //当前的文本
          text: inputData.toString(),
          //光标的位置
          selection: TextSelection.collapsed(
              //设置光标的位置在 文本最后
              offset: inputData.toString().length));
    });
  }
}

List<BankBean> banks = [
  BankBean(backName: "中国银行", icon: "BOC"),
  BankBean(backName: "工商银行", icon: "ICBC"),
  BankBean(backName: "农业银行", icon: "ABC"),
  BankBean(backName: "建设银行", icon: "CCB"),
  BankBean(backName: "交通银行", icon: "BOCM"),
  BankBean(backName: "平安银行", icon: "SPABANK"),
  BankBean(backName: "招商银行", icon: "CMB"),
  BankBean(backName: "邮储银行", icon: "PSBC"),
  BankBean(backName: "中信银行", icon: "CITIC"),
  BankBean(backName: "广发银行", icon: "GDB"),
  BankBean(backName: "华夏银行", icon: "HXB"),
  BankBean(backName: "光大银行", icon: "CEB"),
  BankBean(backName: "兴业银行", icon: "CIB"),
  BankBean(backName: "浦发银行", icon: "SPDB"),
  BankBean(backName: "汇丰银行", icon: "HSBC"),
  BankBean(backName: "北京银行", icon: "BOB"),
  BankBean(backName: "晋商银行", icon: "JSB"),
  BankBean(backName: "武汉银行", icon: "WHCB"),
  BankBean(backName: "汉口银行", icon: "HKCB"),
  BankBean(backName: "成都银行", icon: "CDCB"),
  BankBean(backName: "宁波银行", icon: "NBCB"),
  BankBean(backName: "渤海银行", icon: "BOHAIB"),
  BankBean(backName: "上海银行", icon: "SHBANK"),
  BankBean(backName: "江苏银行", icon: "JSBANK"),
  BankBean(backName: "恒丰银行", icon: "EGBANK"),
  BankBean(backName: "花旗银行", icon: "CITI")
];

List<String> banksList = [
  "中国银行",
  "农业银行",
  "工商银行",
  "交通银行",
  "建设银行",
  "招商银行",
  "中信银行",
  "平安银行",
  "广发银行",
  "邮储银行",
  "浦发银行",
  "光大银行",
  "民生银行",
  "兴业银行",
  "华夏银行",
  "恒丰银行",
  "武汉银行",
  "汉口银行",
  "杭州银行",
  "浙商银行",
  "长安银行",
  "北京银行",
  "北京农商银行",
  "中关村银行",
  "天津银行",
  "徽商银行",
  "上海银行",
  "龙江银行",
  "大连银行",
  "蒙商银行",
  "河北银行",
  "齐鲁银行",
  "南京银行",
  "宁波银行",
  "成都银行",
  "哈尔滨银行",
  "渤海银行",
  "广州银行",
  "重庆银行",
  "重庆农村商业银行",
  "东莞银行",
  "东莞农村商业银行",
  "汇丰银行",
  "花旗银行",
  "渣打银行",
  "东亚银行",
];

const String RECORDS_KEY = "transfer_records";
const String CONTACTS_KEY = "contact_records";
const String CURRENT_USER_KEY = "current_account";
const String SHOW_GESTURE_PASSWORD_KEY = "show_gesture_password";
