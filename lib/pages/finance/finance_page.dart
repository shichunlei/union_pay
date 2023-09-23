import 'package:flutter/material.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({Key? key}) : super(key: key);

  @override
  createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: Container());
  }

  @override
  bool get wantKeepAlive => true;
}
