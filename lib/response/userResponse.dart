import 'package:json_annotation/json_annotation.dart';

@JsonSerializable() 

class UserResponse {
  late final String id;
  late final String dni;
  late final String phone;
  late final String name;
  late final String company;

  
}
