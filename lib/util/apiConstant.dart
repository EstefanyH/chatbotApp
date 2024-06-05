
import 'package:appchatbot/util/constantGlobal.dart';

class APIConstant {
  
  static const String SERVER_API_URL = 'https://chatbot-electrodunas.analytia.pe/';
  static String API_LOGIN = '${SERVER_API_URL}loginemployee';
  static String API_SEND = '${SERVER_API_URL}app/send-msg/${IdUsuario}';
  static String API_CREATE = '${SERVER_API_URL}employee/create';
  static String API_CLOSE = '${SERVER_API_URL}app/close-session/${IdUsuario}';
  
  static const String ContentType = 'application/json';
 }

 enum TypeMessage {
   text,
   img,
   select,
   list,
   item
 }