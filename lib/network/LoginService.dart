import 'dart:convert';
import 'dart:io';


import 'package:appchatbot/inetwork/ILoginService.dart';
import 'package:appchatbot/request/UserRequest.dart';
import 'package:appchatbot/response/closeResponse.dart';
import 'package:appchatbot/response/loginResponse.dart';
import 'package:appchatbot/util/apiConstant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService extends ILoginService {

  @override
  Future<LoginResponse?> authentification(UserResquest request) async {
    
    final url = Uri.parse(APIConstant.API_LOGIN);
    final response = await http.post(url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
      },
      body: jsonEncode(request.toJson()), // Convierte el cuerpo a JSON
    );

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  @override
  Future<CloseResponse?> closeAuthetication() async{
    final url = Uri.parse(APIConstant.API_CLOSE);
    final response = await http.put(url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
      }, // Convierte el cuerpo a JSON
      body: null,
    );

    if (response.statusCode == HttpStatus.ok) {
      return CloseResponse.fromJson(jsonDecode(response.body));
    }

    return null;
  }

}