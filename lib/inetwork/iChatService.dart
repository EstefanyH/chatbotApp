import 'package:appchatbot/request/sendRequest.dart';

abstract class IChatService {

  Future<void> chatBotResponse(SendRequest request);
  Future<void> addMessage(String msg, bool isBot);
  Future<void> clearMessage();
  
}