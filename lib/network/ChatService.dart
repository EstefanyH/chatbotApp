import 'dart:convert';
import 'dart:io';
import 'package:appchatbot/inetwork/iChatService.dart';
import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:http/http.dart' as http;

class ChatService extends IChatService{
  String TokenAccess =  'Bearer ${Token}';

  @override
  Future<dynamic?> chatBotResponse(SendRequest request) async {
    // TODO: implement chatBotResponse
    
    final url = Uri.parse(APIConstant.API_SEND);
    
    print('chat->url : ${APIConstant.API_SEND}');
    print('chat->Token: ${TokenAccess}');
    
    final response = await http.post(url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
        'Authorization': TokenAccess,
      },
      body: jsonEncode(request.toJson()), 
    );

    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(response.body);
    }

    return null;
  }
  
}