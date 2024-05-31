import 'dart:convert';
import 'dart:ffi';

import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/sendResponse.dart';
import 'package:appchatbot/service/apiConstant.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatViewModel with ChangeNotifier {
  final chatFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  String resultado = "";
  //final List<Map<String, String>> _messages = [];

  void sendMessage(BuildContext context, { required List<Map<String, String>> messages ,required String texto }) async {
  
    chatBotResponse(SendRequest(msg: texto)) ;
    //texto = ''; 
    //messages = _messages; 
  }

  Future<void> chatBotResponse(SendRequest request) async {
    final url = Uri.parse(APIConstant.API_SEND);
    String TokenAccess =  'Bearer ${Token}';
    print('Token: ${TokenAccess}');

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
       
        //setState(() {
        //_messages.add({'text': data.message[0].toString(), 'sender': 'bot'});
        //});
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
