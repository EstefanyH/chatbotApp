import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:appchatbot/inetwork/iChatService.dart';
import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/sendResponse.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService extends IChatService with ChangeNotifier{
  String TokenAccess =  'Bearer ${Token}';

  final List<Map<String, String>>? _messages = [];
  List<Map<String, String>>? get messages => _messages;

  @override
  Future<void> addMessage(String msg, bool isBot) async {
    var user = (isBot)? 'bot' : 'user';
    _messages?.add({'text': msg, 'sender': user});
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
      if (result != null){
          //_messages?.add({'text': result.message[0], 'sender': 'bot'});
          addMessage(result.message[0], true);
        } 
    }
 
  }
  
  @override
  Future<void> clearMessage() async {
    // TODO: implement clearMessage
    _messages?.clear();
  }
  
}