import 'dart:convert';
import 'package:appchatbot/network/LoginService.dart';
import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/sendResponse.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatViewModel with ChangeNotifier {
  final chatFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  late final LoginService service;

  ChatViewModel (){
    service = LoginService();
  }

  String resultado = "";

  void sendMessage(BuildContext context, { required List<Map<String, String>> messages ,required String texto }) async {
    chatBotResponse(SendRequest(msg: texto.trim().toString())); 
  }

  void close(BuildContext context) async {
    var result = await service.closeAuthetication();
    print(result);
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
   
  }

  Future<void> chatBotResponse(SendRequest request) async {
    final url = Uri.parse(APIConstant.API_SEND);
    String TokenAccess =  'Bearer ${Token}';
    //String TokenAccess = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTEwMTcyYzFiZDMzNTk0ZjFlZTNjYSIsImRuaSI6Ijc0OTA4NTU2IiwiaWF0IjoxNzE3MTgwNTczLCJleHAiOjE3MTcyNjY5NzN9.KbyU_qJAXXIEuYlNqLosy5zTCrg-bgYYGfhSL4Epugs';
    print('Token: ${TokenAccess}');
    print('chatBotResponse->Request:${jsonEncode(request.toJson())}');

    try {


    final response = await http.post(
      url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
        'Authorization': TokenAccess,
      },
      body: jsonEncode(request.toJson()), // Convierte el cuerpo a JSON
    ); 

      if (response.statusCode == 200) {
        final data = SendResponse.fromJson(jsonDecode(response.body));
       
        resultado =  data.message[0].toString();
      } else {
        print('Error en la solicitud: ${response.body}'); 
      }
    } catch (error) {
    // Maneja cualquier otro error
    print('Error en la solicitud: $error'); 
    }
  } 
}
