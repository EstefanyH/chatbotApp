import 'dart:convert';
import 'dart:io';
import 'package:appchatbot/inetwork/ILoginService.dart';
import 'package:appchatbot/request/UserRequest.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService extends ILoginService with ChangeNotifier {

  LoginService() : super();

  @override
  Future<dynamic?> authentification(UserResquest request) async {
    
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