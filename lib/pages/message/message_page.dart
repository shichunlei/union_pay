import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin {
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
    return Scaffold(
        appBar: AppBar(title: const Text("消息"), centerTitle: true, actions: [
          Center(child: TextButton(child: const Text("添加", style: TextStyle(color: Colors.grey)), onPressed: () {}))
        ]),
        body: Container());
  }

  @override
  bool get wantKeepAlive => true;
}
