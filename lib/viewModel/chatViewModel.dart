import 'package:appchatbot/network/ChatService.dart';
import 'package:appchatbot/network/LoginService.dart';
import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/closeResponse.dart';
import 'package:appchatbot/response/sendResponse.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:flutter/material.dart';

class ChatViewModel with ChangeNotifier {
  final chatFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  late final LoginService loginservice;
  late final ChatService chatService;

  ChatViewModel (){
    loginservice = LoginService();
    chatService = ChatService();
  }

  String resultado = "";

  void sendMessage(BuildContext context, { required List<Map<String, String>> messages ,required String texto }) async {
     
    var request = SendRequest(msg: texto.trim().toString());
    try {

        final data = await chatService.chatBotResponse(request);
        SendResponse result = SendResponse.fromJson(data);
        if (result != null){
          resultado =  result.message[0].toString();
        } 
  
    } catch (error) {
    // Maneja cualquier otro error
      print('Error en la solicitud: $error'); 
    }
  }

  void close(BuildContext context) async {
    var data = await loginservice.closeAuthetication();
    CloseResponse result = CloseResponse.fromJson(data);
    if (result.data){
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
   
  }

}
