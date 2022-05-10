import 'package:flutter/material.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  final int chatType;

  @override
  createState() => _ChatPageState();

  ChatPage({required this.chatType});
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _chatController = TextEditingController();
  late int _chatType;

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();
    _chatType = widget.chatType;
  }

  @override
  Widget build(BuildContext context) {
    if (_chatType == 1) {
      return userChat();
    } else if (_chatType == 2) {
      return deliveryCourierChat();
    }
    return supportChat();
  }

  Scaffold userChat() {
    return Scaffold(
        appBar: customAppBar(title: 'Chat del usuario'),
        backgroundColor: ghostWhite,
        body: Column(children: [
          Expanded(child: Column()),
          customInputChat(controller: _chatController, onClick: () {})
        ]));
  }

  Scaffold deliveryCourierChat() {
    return Scaffold(
        appBar: customAppBar(title: 'Chat del mensajero'),
        backgroundColor: ghostWhite,
        body: Column(children: [
          Expanded(child: Column()),
          customInputChat(controller: _chatController, onClick: () {})
        ]));
  }

  Scaffold supportChat() {
    return Scaffold(
        appBar: customAppBar(title: 'Chat del soporte'),
        backgroundColor: ghostWhite,
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(child: Column()),
          customInputChat(controller: _chatController, onClick: () {})
        ]));
  }
}
