import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:union_pay/utils/sp_util.dart';

import 'pages/index_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SpUtil.getInstance();

  runZonedGuarded(() async {
    /// 强制竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
      runApp(const MyApp());

      if (Platform.isAndroid) {
        // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
  }, (Object exception, StackTrace stackTrace) async {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        builder: EasyLoading.init(),
        theme: ThemeData(
            primaryColor: const Color(0xffED171B),
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                color: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                iconTheme: IconThemeData(color: Colors.black),
                actionsIconTheme: IconThemeData(color: Colors.black)),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 4,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xffED171B),
                unselectedItemColor: Color(0xFF7C7C7C))),
        home: const IndexPage());
  }
}
