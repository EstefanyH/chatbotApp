import 'package:appchatbot/request/sendRequest.dart';

abstract class IChatService {
  
  Future<dynamic?> chatBotResponse(SendRequest request);
}