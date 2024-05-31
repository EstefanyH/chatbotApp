import 'dart:convert';
import 'dart:io';

import 'package:appchatbot/inetwork/iChatService.dart';
import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/sendResponse.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:http/http.dart' as http;

class ChatService extends IChatService{

  @override
  Future<SendResponse?> chatBotResponse(SendRequest request) async {
    // TODO: implement chatBotResponse
    
    final url = Uri.parse(APIConstant.API_SEND);
    final response = await http.post(url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
      },
      body: jsonEncode(request.toJson()), // Convierte el cuerpo a JSON
    );

    if (response.statusCode == HttpStatus.ok) {
      return SendResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }
  
}