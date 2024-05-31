import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserResquest {
  final String dni;
  final String password;

  const UserResquest({
    required this.dni,
    required this.password
  });
 

  // Método para serializar una instancia de User a JSON
  Map<String, dynamic> toJson() => {
    'dni': dni,
    'password': password
  };

}