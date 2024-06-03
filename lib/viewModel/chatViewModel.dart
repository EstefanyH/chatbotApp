import 'package:appchatbot/network/ChatService.dart';
import 'package:appchatbot/network/LoginService.dart';
import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/closeResponse.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/view/Chat/chatbotPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatViewModel extends State<ChatBotPage> with ChangeNotifier {
 
  ChatService get chatmanager =>  context.read<ChatService>(); 

  @override
  void initState() { 
    super.initState();
  }

  void showEventOption(String id) async {
    switch(id){
      case 'tipo_retencion':
        
        break;
      default:
        sendMessage(texto: id);
        break;
    }
  }

  void sendMessage({ required String texto }) async {  
    
    var request = SendRequest(msg: texto.trim().toString()); 

    setState(() {
      chatmanager.addMessage(request.msg, null, false);
    });
    
    try {
      await chatmanager.chatBotResponse(request);

      setState(() { 
        chatmanager.sendMessage;
      });
       
    } catch (error) { 
      print('Error en la solicitud: $error'); 
    }
  }

  void closeView() async {
    var data = await chatmanager.closeAuthetication();
    CloseResponse result = CloseResponse.fromJson(data);
    if (result.data){
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
  
  @override
  Widget build(BuildContext context) { 
    throw UnimplementedError();
  }

}
