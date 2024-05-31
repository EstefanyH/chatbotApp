import 'dart:async';
import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/widget/appProgressIndicator.dart';
import 'package:flutter/material.dart'; 
 

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Electrodunas",
            style: titleStyleIndigo),
          SizedBoxH20(),
          AppProgressIndicator(),
        ],),),
    );
  }
}