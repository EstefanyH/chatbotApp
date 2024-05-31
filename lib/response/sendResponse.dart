import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SendResponse {
  final List<String> message;
  final String data;

  const SendResponse({
    required this.message,
    required this.data
  });
  
  factory SendResponse.fromJson(Map<String,dynamic> json) => SendResponse(
      message: List<String>.from(json['message'])  ,
      data: (json['data'] == null) ? "" : json['data'] 
    );
}
  