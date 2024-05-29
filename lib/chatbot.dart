import 'package:appchatbot/view/chatscreen.dart';
import 'package:flutter/material.dart';
/*
void main() {
  runApp(const ChatBotApp());
}*/

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBot App',
      theme: ThemeData(
        primarySwatch: Colors.blue),
        home: const ChatScreen(),);
  }
}
