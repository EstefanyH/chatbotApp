import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CloseResponse {
  final bool data;

  CloseResponse({required this.data});

  factory CloseResponse.fromJson(Map<String,dynamic> json) {
    return switch(json){
      {
        'data': bool data, 
      } => CloseResponse(data: data),
      _ => throw const FormatException('Failed to load CloseReponse.'),
    };
  }

}