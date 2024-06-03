
import 'package:appchatbot/request/accountRequest.dart';

abstract class IAccountService {

  Future<dynamic?> createAcoount(AccountRequest request);
}