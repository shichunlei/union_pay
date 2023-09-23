import 'package:flutter/material.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({Key? key}) : super(key: key);

  @override
  createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> with AutomaticKeepAliveClientMixin {
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
