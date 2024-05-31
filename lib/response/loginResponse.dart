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

  factory LoginResponse.fromJson(Map<String,dynamic> json) {
    return switch(json){
      {
        'user': UserResponse user,
        'token': String token 
      } => LoginResponse(user: user, token: token),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
