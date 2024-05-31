import 'package:appchatbot/view/Chat/chatbot.dart';
import 'package:appchatbot/view/Login/loginPage.dart';
import 'package:appchatbot/view/Splash/loadingPage.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String loadingPage = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = 'registerPage';
  static const String chatAppHomePage = 'firstAppHomePage';

  static Route<dynamic> onGenerationRoute(RouteSettings setting){
    switch(setting.name) {
      case loadingPage: 
        return MaterialPageRoute(builder: (context) => const LoadingPage());
      case loginPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      /*case registerPage:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      */
      case chatAppHomePage:
        return MaterialPageRoute(builder: (context) => const ChatBotApp());
      
      default:
        throw Exception("No route found!");
    }
  }
}

