import 'package:appchatbot/network/ChatService.dart';
import 'package:appchatbot/network/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'route/routeManager.dart';

void main() {
  runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
/*
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  } */

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    switch(state) {
      
      case AppLifecycleState.detached:
        // TODO: Handle this case. 
        /*if (IdUsuario != "") {
          service.closeAuthetication();
        }*/
        break;
      case AppLifecycleState.resumed:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
    }
    /*if (state == AppLifecycleState.paused) {
      // La aplicación está en segundo plano
      // Realizar limpieza o guardar estado aquí
    }*/
    print("-- State app: ${state}");
    super.didChangeAppLifecycleState(state);
  }
  
  @override
  Widget build(BuildContext context) {
 
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginService()),
        ChangeNotifierProvider(create: (context) => ChatService()),
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