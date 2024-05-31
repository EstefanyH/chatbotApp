import 'dart:convert';

import 'package:appchatbot/response/userResponse.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable() 
class LoginResponse {
  final UserResponse user;
  final String token;

  const LoginResponse({
    required this.user,
    required this.token
  });

  factory LoginResponse.fromJson(Map<String,dynamic> json) => LoginResponse(
     user: UserResponse.fromJson(json['user'])  ,
     token: json['token']
    );
}

