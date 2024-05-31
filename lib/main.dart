import 'package:appchatbot/viewModel/chatViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'route/routeManager.dart';
import 'viewModel/userViewModel.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
      ],
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteManager.onGenerationRoute,
        initialRoute: RouteManager.loadingPage,
        theme: ThemeData( 
          primarySwatch: Colors.indigo
          ),
      ),
    );
  }
}