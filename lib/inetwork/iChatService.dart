import 'package:appchatbot/request/sendRequest.dart';
import 'package:appchatbot/util/apiConstant.dart';

abstract class IChatService {

  Future<void> chatBotResponse(SendRequest request);
  Future<dynamic?> closeAuthetication();
  Future<void> addMessage(String msg, dynamic data, bool isBot, TypeMessage type);
  Future<void> clearMessage();
}