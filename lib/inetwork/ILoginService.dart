
import 'package:appchatbot/request/UserRequest.dart';
import 'package:appchatbot/response/closeResponse.dart';
import 'package:appchatbot/response/loginResponse.dart';

abstract class ILoginService {
  
  Future<LoginResponse?> authentification(UserResquest request);

  Future<CloseResponse?> closeAuthetication();
}