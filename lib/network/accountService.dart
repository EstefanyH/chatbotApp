import 'dart:convert';
import 'dart:io';

import 'package:appchatbot/inetwork/iAccountService.dart';
import 'package:appchatbot/request/accountRequest.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AccountService extends IAccountService with ChangeNotifier {
  
  @override
  Future createAcoount(AccountRequest request) async { 
    final url = Uri.parse(APIConstant.API_LOGIN);
    final response = await http.post(url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
      },
      body: jsonEncode(request.toJson()), // Convierte el cuerpo a JSON
    );

    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(response.body);
    }

    return null;
  }
  
}