import 'package:json_annotation/json_annotation.dart';

@JsonSerializable() 
class UserResponse {
  final String id;
  final String dni;
  final String phone;
  final String name;
  final String company;

  const UserResponse({
    required this.id,
    required this.dni,
    required this.phone,
    required this.name,
    required this.company
  });

  factory UserResponse.fromJson(Map<String,dynamic> json) {
    return switch(json){
      {
        'id': String id,
        'dni': String dni,
        'phone': String phone,
        'name': String name,
        'company': String company 
      } => UserResponse(id: id, dni: dni, phone: phone, name: name, company: company),
      _ => throw const FormatException('Failed to load UserResponse.'),
    };
  }
  
}
