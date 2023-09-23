import 'package:flutter/material.dart';
import 'package:union_pay/pages/finance/finance_page.dart';
import 'package:union_pay/pages/home/home_page.dart';
import 'package:union_pay/pages/message/message_page.dart';
import 'package:union_pay/pages/mine/mine_page.dart';
import 'package:union_pay/pages/promo/promo_page.dart';
import 'package:union_pay/utils/sp_util.dart';
import 'package:union_pay/utils/utils.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  int currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();

    if (Utils.isEmpty(SpUtil.getString(CURRENT_USER_KEY))) {
      SpUtil.setString(CURRENT_USER_KEY, "13000008810");
    }

    SpUtil.setBool(SHOW_GESTURE_PASSWORD_KEY, true);

    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            controller: pageController,
            onPageChanged: (int index) {
              currentIndex = index;
              setState(() {});
            },
            physics: const ClampingScrollPhysics(),
            children: const [HomePage(), PromoPage(), MessagePage(), FinancePage(), MinePage()]),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/home_unselected_big.png", width: 28, height: 28),
                  activeIcon: Image.asset("assets/images/home_selected_big.png", width: 28, height: 28),
                  label: "首页"),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/promo_unselected_big.png", width: 28, height: 28),
                  activeIcon: Image.asset("assets/images/promo_selected_big.png", width: 28, height: 28),
                  label: "生活"),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/msg_unselected_big.png", width: 28, height: 28),
                  activeIcon: Image.asset("assets/images/msg_selected_big.png", width: 28, height: 28),
                  label: "消息"),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/finance_unselected_big.png", width: 28, height: 28),
                  activeIcon: Image.asset("assets/images/finance_selected_big.png", width: 28, height: 28),
                  label: "金融"),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/images/mine_unselected_big.png", width: 28, height: 28),
                  activeIcon: Image.asset("assets/images/mine_selected_big.png", width: 28, height: 28),
                  label: "我的")
            ],
            currentIndex: currentIndex,
            onTap: (int index) {
              currentIndex = index;
              pageController.jumpToPage(index);
              setState(() {});
            }));
  }
}
