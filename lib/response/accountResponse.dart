import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AccountResponse {
  final String phone;
  final String dni;
  final String company;
  final String password;
  final String name;
  final String id;
  final int v;

  AccountResponse({
    required this.phone,
    required this.dni,
    required this.company,
    required this.password,
    required this.name,
    required this.id,
    required this.v
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'phone': String phone,
        'dni': String dni,
        'company': String company,
        'password': String password,
        'name': String name,
        '_id': String id,
        '__v': int v
      } => AccountResponse(phone: phone, dni: dni, company: company, password: password, name: name, id: id, v: v),
      _ => throw const FormatException('Failed to load AccountResponse.'),
    };
  }
}