import 'dart:convert';
import 'dart:io';
import 'package:appchatbot/inetwork/iChatService.dart';
import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/sendMessage.dart';
import 'package:appchatbot/response/sendResponse.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService extends IChatService with ChangeNotifier{
  String TokenAccess =  'Bearer ${Token}';
   
  final List<SendMessage>? _sendMessage = [];  
  List<SendMessage>? get sendMessage => _sendMessage;
  
  @override
  Future<void> addMessage(String msg, dynamic data, bool isBot, TypeMessage type) async {
    List<Map<String, String>>? _messages = [];
    List<Map<String, String>>? _options = [];
    List<Map<String, String>>? _suboptions = [];
 
    var user = (isBot)? 'bot' : 'user';
    _messages.add({'text': msg, 'sender': user, 'type': type.name});

    if (data != null) {
      if (data.length < 3){
        for (var f in data) {
          _options.add({'text': f['name'], 'code': f['code'], 'type': TypeMessage.list.name});
        }
      } else {
          var code = '', title = '', subtitle = '';
          var _splitMsg = msg.split('*'); 
          var category = _splitMsg[1];

          _options.add({'text': category, 'code': 'tipo', 'type': TypeMessage.select.name});

          for(var f in data){
            switch(category){
              case 'Tipo de rendición de gastos':
                title = f['Codigo'];
                subtitle = '${f['Descripcion']}, tiene un saldo de  ${f['Saldo']}';
                code = f['Codigo'];
                break;
              case 'Categoría':
                title = f['Descripcion'];
                subtitle = '';
                code = f['Codigo'];
                break;
              case 'Centro de costo':
                title = f['Descripcion'];
                subtitle = '';
                code = f['Codigo'];
                break;
            } //item
            _suboptions.add({'text': title, 'subtitle': subtitle, 'code': code, 'type': TypeMessage.item.name});
          }

          if (_suboptions.length > 0) {
            title = 'Volver al inicio';
            subtitle = '';
            _suboptions.add({'text': title, 'subtitle': subtitle, 'code': code,  'type': TypeMessage.item.name});
          }
      }
    }

    var send = SendMessage(messages: _messages[0], options: _options, subOptions: _suboptions);
    _sendMessage?.add(send);
    
  }

  @override
  Future<void> chatBotResponse(SendRequest request) async {
    
    final url = Uri.parse(APIConstant.API_SEND);
  
    final response = await http.post(url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
        'Authorization': TokenAccess,
      },
      body: jsonEncode(request.toJson()), 
    );

    if (response.statusCode == HttpStatus.ok) {
      final result = SendResponse.fromJson(jsonDecode(response.body));
      if (result != null) {
          addMessage(result.message[0], result.data, true, TypeMessage.text);
        } 
    }
  }

  @override
  Future<dynamic?> closeAuthetication() async{
    final url = Uri.parse(APIConstant.API_CLOSE);
    print('url ${url}');
    final response = await http.put(url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
      }, // Convierte el cuerpo a JSON
      body: null,
    );

    if (response.statusCode == HttpStatus.ok) {
      print('response -> data: ${jsonDecode(response.body)}}');
      return jsonDecode(response.body);
    }

    return null;
  }
  
  @override
  Future<void> clearMessage() async {
    _sendMessage?.clear(); 
  }
  
}