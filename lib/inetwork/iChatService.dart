import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/response/sendResponse.dart';

abstract class IChatService {
  
  Future<SendResponse?> chatBotResponse(SendRequest request);
}