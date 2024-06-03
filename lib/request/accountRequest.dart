
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AccountRequest {
  final String phone;
  final String dni;
  final String password;
  final String  company;

  AccountRequest({
    required this.phone,
    required this.dni,
    required this.password,
    required this.company
  });

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'dni': dni,
    'password': password,
    'company': company
  };

}