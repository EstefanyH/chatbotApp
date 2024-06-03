
import 'package:appchatbot/request/UserRequest.dart';

abstract class ILoginService {
  
  Future<dynamic?> authentification(UserResquest request);

}