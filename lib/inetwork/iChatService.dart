import 'package:appchatbot/request/sendRequest.dart';

abstract class IChatService {

  Future<void> chatBotResponse(SendRequest request);
  Future<dynamic?> closeAuthetication();
  Future<void> addMessage(String msg, dynamic data, bool isBot);
  Future<void> clearMessage();
}