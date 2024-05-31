import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/view/Chat/chatbotForm.dart';
import 'package:appchatbot/view/Chat/chatscreen.dart';
import 'package:flutter/material.dart';
 
class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, RouteManager.loginPage);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, 
          color: Colors.indigo,)),
        backgroundColor: Colors.white,
        title: const Text("ChatBot", 
          style: style16Black,),
      ),
      backgroundColor: Colors.white,
      body: const SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Center(
                child: ChatBotForm(),),)
          ],)),
      );
  }
}
