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
  Future<void> addMessage(String msg, dynamic data, bool isBot) async {
    List<Map<String, String>>? _messages = [];
    List<Map<String, String>>? _options = [];
 
    var user = (isBot)? 'bot' : 'user';
    _messages.add({'text': msg, 'sender': user, 'type': 'text'});

    if (data != null) {
      if (data.length < 3){
        for (var f in data) {
          _options.add({'text': f['name'], 'code': f['code'], 'type': 'list'}); 
        }
      } else {

          _options.add({'text': 'Tipo de redención', 'code': 'tipo_retencion', 'type': 'select'});
      }
    }
    var send = SendMessage(messages: _messages[0], options: _options);
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
          addMessage(result.message[0], result.data, true);  
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